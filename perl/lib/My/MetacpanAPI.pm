package My::MetacpanAPI;

use v5.30;
use warnings;

use MetaCPAN::Client;
use DateTime::Format::RFC3339;
use DateTime::Format::ISO8601;
use JSON::Validator;
use Data::Dumper;

use experimentals;

# the metacpan client
sub _mcpan {
    state $mcpan = do {
        my $m = MetaCPAN::Client->new;
        $m->ua->agent('perlmodules.net 2.0');
        $m;
    };
}

sub fetch_recent_releases ($class, $min_dt, %opts) {
    # opts can be: debug: bool (prints errors)

    my $min_dt_fmt = DateTime::Format::RFC3339->format_datetime($min_dt);

    my $releases = _mcpan->all(
        'releases',
        {
            es_filter => {
                and => [
                    {term  => {authorized => 1}},
                    {term  => {maturity   => 'released'}},
                    {range => {date       => {gte => $min_dt_fmt}}},
                ],
            },

            fields => [
                qw/ name distribution date version author /
            ],
        }
    );

    my $jv = JSON::Validator->new;
    $jv->schema({
        type       => 'object',
        required   => [qw/ name distribution date version author /],
        properties => {
            name         => {type => 'string', minLength => 1, maxLength => 255},
            distribution => {type => 'string', minLength => 1, maxLength => 255},
            date         => {type => 'string', minLength => 1},
            version      => {type => [qw/string number/], minLength => 1, maxLength => 255},
            author       => {type => 'string', minLength => 1, maxLength => 50},
        },
    });
    my $dt_f = DateTime::Format::ISO8601->new;

    my @releases;
    RELEASE: while (my $release = $releases->next) {
        my $rel_hash = {
            name         => $release->name,
            distribution => $release->distribution,
            date         => $release->date,
            version      => $release->version,
            author       => $release->author,
        };
        my @errors = $jv->validate($rel_hash);
        my $dt = eval { $dt_f->parse_datetime($rel_hash->{date}) };
        push @errors, "erroneous date ($rel_hash->{date})" if !$dt;
        if (@errors) {
            print Dumper({
                release => $rel_hash,
                errors => \@errors,
            }) if $opts{debug};
            next RELEASE;
        } else {
            $dt->set_time_zone('UTC');
            $rel_hash->{date} = $dt;
        }
        push @releases, $rel_hash;
    }

    @releases = sort { $a->{date} <=> $b->{date} } @releases;

    return \@releases;
}

1;

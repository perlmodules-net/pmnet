#!/opt/perl-5.30/bin/perl

use v5.30;
use warnings;
use FindBin '$RealBin';
use lib "$RealBin/../local/lib/perl5", "$RealBin/../lib";

use MyApp;

use DBIx::Class::Schema::Loader 'make_schema_at';

use experimentals;

my $conf = MyApp->new->config;
my ($dbname, $host, $user, $pass) = $conf->{db}->@{qw/ dbname host user pass /};

make_schema_at(
    'My::Schema',
    {
        debug              => 0,
        dump_directory     => "$RealBin/../lib",
        skip_relationships => 1,
        quiet              => 1,
        generate_pod       => 0,
    },
    [qq{DBI:Pg:dbname="$dbname";host="$host"}, $user, $pass],
);

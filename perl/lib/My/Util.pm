package My::Util;

use v5.30;
use warnings;

use DDP ();

use Exporter 'import';
our @EXPORT_OK = qw/ p /;

use experimentals;

# With this p you can do stuff like: p $array[-1]{property}
# whereas before, with DDP's p, you could only p a variable

sub p :prototype(_) {
    DDP::p($_[0]);
}

1;

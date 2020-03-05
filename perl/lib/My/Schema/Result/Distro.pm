use utf8;
package My::Schema::Result::Distro;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->table("distro");
__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "distro_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("idx_n", ["name"]);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-03-05 16:05:38
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:m0ex+BzYfhZd96ARHifIAQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

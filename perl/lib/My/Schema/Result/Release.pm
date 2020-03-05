use utf8;
package My::Schema::Result::Release;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->table("release");
__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "release_id_seq",
  },
  "author",
  { data_type => "varchar", is_nullable => 0, size => 128 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "version",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "datetime",
  { data_type => "timestamp with time zone", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("idx_an", ["author", "name"]);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-03-05 16:05:38
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7qlhp8VHFrgA/SfTJv81/g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

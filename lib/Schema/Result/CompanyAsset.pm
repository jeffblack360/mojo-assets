use utf8;
package Schema::Result::CompanyAsset;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("company_asset");
__PACKAGE__->add_columns(
  "company_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "asset_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);
__PACKAGE__->belongs_to(
  "asset",
  "Schema::Result::Asset",
  { id => "asset_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);
__PACKAGE__->belongs_to(
  "company",
  "Schema::Result::Company",
  { id => "company_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-04-02 15:50:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QLfnwOJVO/Qu0LRoFreqMw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

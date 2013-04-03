use utf8;
package Schema::Result::Asset;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("asset");
__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "short_desc",
  { data_type => "text", is_nullable => 1 },
  "desc",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->has_many(
  "company_assets",
  "Schema::Result::CompanyAsset",
  { "foreign.asset_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "user_assets",
  "Schema::Result::UserAsset",
  { "foreign.asset_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-04-02 15:50:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:c+VsPlLiNYPLnH7ZBjwEoA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

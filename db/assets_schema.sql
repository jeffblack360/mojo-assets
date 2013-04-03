PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;

CREATE TABLE company (
id integer primary key autoincrement,
name text
);

CREATE TABLE user (
id integer primary key autoincrement,
last_name text,
first_name text,
middle_name text
);

CREATE TABLE asset (
id integer primary key autoincrement,
name text,
short_desc text,
desc text
);

CREATE TABLE company_user (
company_id integer,
user_id integer,
FOREIGN KEY(company_id) REFERENCES company(id),
FOREIGN KEY(user_id) REFERENCES user(id)
);

CREATE TABLE company_asset (
company_id integer,
asset_id integer,
FOREIGN KEY(company_id) REFERENCES company(id),
FOREIGN KEY(asset_id) REFERENCES asset(id)
);

CREATE TABLE user_asset (
user_id integer,
asset_id integer,
FOREIGN KEY(user_id) REFERENCES user(id),
FOREIGN KEY(asset_id) REFERENCES asset(id)
);

COMMIT;

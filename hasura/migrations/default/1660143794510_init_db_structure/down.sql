
alter table "public"."user" drop constraint "user_role_id_fkey";

DROP TABLE "public"."role";

DROP TABLE "public"."user";

DROP TABLE "public"."feature_tag";

alter table "public"."feature"
  add constraint "feature_project_id_fkey"
  foreign key (project_id)
  references "public"."project"
  (id) on update restrict on delete restrict;
alter table "public"."feature" alter column "project_id" drop not null;
alter table "public"."feature" add column "project_id" int4;

DROP TABLE "public"."env_feature";

alter table "public"."feature" alter column "is_enable" set default false;
alter table "public"."feature" alter column "is_enable" drop not null;
alter table "public"."feature" add column "is_enable" bool;

DROP TABLE "public"."environment";

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."project" add column "code" text
--  not null;

DROP TABLE "public"."feature";

DROP TABLE "public"."project";


CREATE TABLE "public"."project" ("id" serial NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "name" text NOT NULL, "description" text, PRIMARY KEY ("id") );
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_project_updated_at"
BEFORE UPDATE ON "public"."project"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_project_updated_at" ON "public"."project" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

CREATE TABLE "public"."feature" ("id" serial NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "name" text NOT NULL, "description" text, "is_enable" boolean NOT NULL DEFAULT false, "project_id" integer NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("project_id") REFERENCES "public"."project"("id") ON UPDATE restrict ON DELETE restrict);
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_feature_updated_at"
BEFORE UPDATE ON "public"."feature"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_feature_updated_at" ON "public"."feature" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

alter table "public"."project" add column "code" text
 not null;

CREATE TABLE "public"."environment" ("id" serial NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "name" text NOT NULL, "color_code" text NOT NULL, "project_id" integer NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("project_id") REFERENCES "public"."project"("id") ON UPDATE restrict ON DELETE restrict);COMMENT ON TABLE "public"."environment" IS E'a collection of env for each project, a project can have multiple environments, ex: staging, production, development';
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_environment_updated_at"
BEFORE UPDATE ON "public"."environment"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_environment_updated_at" ON "public"."environment" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

alter table "public"."feature" drop column "is_enable" cascade;

CREATE TABLE "public"."env_feature" ("id" serial NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "env_id" integer NOT NULL, "feature_id" integer NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("env_id") REFERENCES "public"."environment"("id") ON UPDATE restrict ON DELETE restrict, FOREIGN KEY ("feature_id") REFERENCES "public"."feature"("id") ON UPDATE restrict ON DELETE restrict);
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_env_feature_updated_at"
BEFORE UPDATE ON "public"."env_feature"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_env_feature_updated_at" ON "public"."env_feature" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

alter table "public"."feature" drop column "project_id" cascade;

CREATE TABLE "public"."feature_tag" ("id" serial NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "name" text NOT NULL, "description" text, "color_code" text, "feature_id" integer NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("feature_id") REFERENCES "public"."feature"("id") ON UPDATE restrict ON DELETE restrict);
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_feature_tag_updated_at"
BEFORE UPDATE ON "public"."feature_tag"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_feature_tag_updated_at" ON "public"."feature_tag" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

CREATE TABLE "public"."user" ("id" serial NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "first_name" text, "last_name" text, "birth" date, "email" text NOT NULL, "password" text NOT NULL, "username" text NOT NULL, "role_id" integer NOT NULL, PRIMARY KEY ("id") );
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_user_updated_at"
BEFORE UPDATE ON "public"."user"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_user_updated_at" ON "public"."user" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

CREATE TABLE "public"."role" ("id" serial NOT NULL, "name" text NOT NULL, "description" text NOT NULL, PRIMARY KEY ("id") );

alter table "public"."user"
  add constraint "user_role_id_fkey"
  foreign key ("role_id")
  references "public"."role"
  ("id") on update restrict on delete restrict;

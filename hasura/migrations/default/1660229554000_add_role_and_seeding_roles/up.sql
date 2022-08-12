

CREATE TRIGGER insert_project AFTER INSERT  ON "project" FOR EACH ROW EXECUTE PROCEDURE on_new_project_added();

CREATE TABLE "public"."webhook" ("id" serial NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "name" text NOT NULL, "description" text, "url" text NOT NULL, "project_id" integer NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("project_id") REFERENCES "public"."project"("id") ON UPDATE restrict ON DELETE restrict);
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
CREATE TRIGGER "set_public_webhook_updated_at"
BEFORE UPDATE ON "public"."webhook"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_webhook_updated_at" ON "public"."webhook" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

CREATE TABLE "public"."event" ("id" serial NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "name" text NOT NULL, "description" text, PRIMARY KEY ("id") );
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
CREATE TRIGGER "set_public_event_updated_at"
BEFORE UPDATE ON "public"."event"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_event_updated_at" ON "public"."event" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

CREATE TABLE "public"."webhook_event" ("id" serial NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "event_id" integer NOT NULL, "webhook_id" integer NOT NULL, "is_enable" boolean NOT NULL DEFAULT false, PRIMARY KEY ("id") , FOREIGN KEY ("webhook_id") REFERENCES "public"."webhook"("id") ON UPDATE restrict ON DELETE restrict, FOREIGN KEY ("event_id") REFERENCES "public"."event"("id") ON UPDATE restrict ON DELETE restrict);
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
CREATE TRIGGER "set_public_webhook_event_updated_at"
BEFORE UPDATE ON "public"."webhook_event"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_webhook_event_updated_at" ON "public"."webhook_event" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

INSERT INTO "public"."event"("id", "created_at", "updated_at", "name", "description") VALUES (1, E'2022-08-11T13:45:51.588253+00:00', E'2022-08-11T13:45:51.588253+00:00', E'on_feature_create', E'trigger when a new feature is added');

INSERT INTO "public"."event"("id", "created_at", "updated_at", "name", "description") VALUES (2, E'2022-08-11T13:46:21.897025+00:00', E'2022-08-11T13:46:21.897025+00:00', E'on_feature_update', E'trigger when a feature is update');

INSERT INTO "public"."event"("id", "created_at", "updated_at", "name", "description") VALUES (3, E'2022-08-11T13:46:37.872291+00:00', E'2022-08-11T13:46:37.872291+00:00', E'on_project_update', E'trigger when a new project is created');

INSERT INTO "public"."event"("id", "created_at", "updated_at", "name", "description") VALUES (4, E'2022-08-11T13:47:00.140603+00:00', E'2022-08-11T13:47:00.140603+00:00', E'on_project_update', E'trigger when a project is updated');

INSERT INTO "public"."event"("id", "created_at", "updated_at", "name", "description") VALUES (5, E'2022-08-11T13:47:33.231821+00:00', E'2022-08-11T13:47:33.231821+00:00', E'on_user_create', E'trigger when a user is created');

INSERT INTO "public"."event"("id", "created_at", "updated_at", "name", "description") VALUES (6, E'2022-08-11T13:47:50.451728+00:00', E'2022-08-11T13:47:50.451728+00:00', E'on_user_update', E'trigger when a user is updated');

INSERT INTO "public"."event"("id", "created_at", "updated_at", "name", "description") VALUES (7, E'2022-08-11T13:48:28.874608+00:00', E'2022-08-11T13:48:28.874608+00:00', E'on_environment_create', E'trigger when a new environment is created');

INSERT INTO "public"."event"("id", "created_at", "updated_at", "name", "description") VALUES (8, E'2022-08-11T13:48:43.92863+00:00', E'2022-08-11T13:48:43.92863+00:00', E'on_environment_update', E'trigger when a environment is updated');

alter table "public"."environment" drop constraint "environment_project_id_fkey",
  add constraint "environment_project_id_fkey"
  foreign key ("project_id")
  references "public"."project"
  ("id") on update restrict on delete cascade;

alter table "public"."webhook" drop constraint "webhook_project_id_fkey",
  add constraint "webhook_project_id_fkey"
  foreign key ("project_id")
  references "public"."project"
  ("id") on update restrict on delete cascade;

alter table "public"."webhook_event" drop constraint "webhook_event_webhook_id_fkey",
  add constraint "webhook_event_webhook_id_fkey"
  foreign key ("webhook_id")
  references "public"."webhook"
  ("id") on update restrict on delete cascade;


CREATE OR REPLACE FUNCTION on_new_project_added()
    RETURNS trigger AS $BODY$
    DECLARE
        webhook_id_1 integer;
        webhook_id_2 integer;
        webhook_id_3 integer;
        webhook_id_4 integer;
        webhook_id_5 integer;
        webhook_id_6 integer;
        webhook_id_7 integer;
        webhook_id_8 integer;
    BEGIN
    
    INSERT INTO public.environment (name, color_code, project_id) VALUES ('development', '#fff' ,NEW.id);
    INSERT INTO public.environment (name, color_code, project_id) VALUES ('production', '#fff' ,NEW.id);
    
    -- init new webhooks for this project, at the moment there're 8 different events
    INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_1;
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (1, webhook_id_1);
    
    INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_2;
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (2, webhook_id_2);

    INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_3;
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (3, webhook_id_3);

    INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_4;
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (4, webhook_id_4);

    INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_5;
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (5, webhook_id_5);

    INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_6;
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (6, webhook_id_6);
    
    INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_7;
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (7, webhook_id_7);
    
    INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_8;
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (8, webhook_id_8);
    
    
    
    RETURN NEW;
    END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION on_new_project_added()
    RETURNS trigger AS $BODY$
    DECLARE
        webhook_id_1 integer;
        webhook_id_2 integer;
        webhook_id_3 integer;
        webhook_id_4 integer;
        webhook_id_5 integer;
        webhook_id_6 integer;
        webhook_id_7 integer;
        webhook_id_8 integer;
    BEGIN
    
    INSERT INTO public.environment (name, color_code, project_id) VALUES ('development', '#fff' ,NEW.id);
    INSERT INTO public.environment (name, color_code, project_id) VALUES ('production', '#fff' ,NEW.id);
    
    -- init new webhooks for this project, at the moment there're 8 different events
    INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_1;
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (1, webhook_id_1);
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (1, webhook_id_1);
    
    
 
    
    
    RETURN NEW;
    END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION on_new_project_added()
    RETURNS trigger AS $BODY$
    DECLARE
        webhook_id_1 integer;
        webhook_id_2 integer;
        webhook_id_3 integer;
        webhook_id_4 integer;
        webhook_id_5 integer;
        webhook_id_6 integer;
        webhook_id_7 integer;
        webhook_id_8 integer;
    BEGIN
    
    INSERT INTO public.environment (name, color_code, project_id) VALUES ('development', '#fff' ,NEW.id);
    INSERT INTO public.environment (name, color_code, project_id) VALUES ('production', '#fff' ,NEW.id);
    
    -- init new webhooks for this project, at the moment there're 8 different events
    INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_1;
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (1, webhook_id_1);
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (2, webhook_id_1);
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (3, webhook_id_1);
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (4, webhook_id_1);
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (5, webhook_id_1);
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (6, webhook_id_1);
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (7, webhook_id_1);
    INSERT INTO webhook_event (event_id, webhook_id) VALUES (8, webhook_id_1);
 
    
    
    RETURN NEW;
    END;
$BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION before_webhook_deleted()
    RETURNS trigger AS $BODY$
    BEGIN
        DELETE FROM public.webhook_event AS w WHERE w.event_id = OLD.id;
    RETURN OLD;
    END;
$BODY$ LANGUAGE plpgsql;

CREATE TRIGGER delete_webhook
   BEFORE DELETE ON webhook FOR EACH ROW
   EXECUTE PROCEDURE before_webhook_deleted();

alter table "public"."webhook_event" drop constraint "webhook_event_webhook_id_fkey",
  add constraint "webhook_event_webhook_id_fkey"
  foreign key ("webhook_id")
  references "public"."webhook"
  ("id") on update restrict on delete no action;

alter table "public"."webhook" drop constraint "webhook_project_id_fkey",
  add constraint "webhook_project_id_fkey"
  foreign key ("project_id")
  references "public"."project"
  ("id") on update restrict on delete no action;

alter table "public"."webhook" drop constraint "webhook_project_id_fkey",
  add constraint "webhook_project_id_fkey"
  foreign key ("project_id")
  references "public"."project"
  ("id") on update restrict on delete restrict;

DROP TRIGGER "delete_webhook" ON "public"."webhook";

alter table "public"."webhook" drop constraint "webhook_project_id_fkey",
  add constraint "webhook_project_id_fkey"
  foreign key ("project_id")
  references "public"."project"
  ("id") on update restrict on delete cascade;

alter table "public"."webhook_event" drop constraint "webhook_event_webhook_id_fkey",
  add constraint "webhook_event_webhook_id_fkey"
  foreign key ("webhook_id")
  references "public"."webhook"
  ("id") on update restrict on delete cascade;

CREATE TABLE "public"."event_history" ("id" serial NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "event_id" integer NOT NULL, "state" boolean NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("event_id") REFERENCES "public"."event"("id") ON UPDATE restrict ON DELETE set null);
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
CREATE TRIGGER "set_public_event_history_updated_at"
BEFORE UPDATE ON "public"."event_history"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_event_history_updated_at" ON "public"."event_history" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

INSERT INTO "public"."role"("id", "name", "description") VALUES (1, E'super admin', E'');

INSERT INTO "public"."role"("id", "name", "description") VALUES (2, E'editor', E'');

INSERT INTO "public"."role"("id", "name", "description") VALUES (3, E'maintainer', E'');

alter table "public"."user" alter column "role_id" set default '3';

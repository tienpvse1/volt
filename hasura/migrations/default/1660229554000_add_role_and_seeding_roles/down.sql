
ALTER TABLE "public"."user" ALTER COLUMN "role_id" drop default;

DELETE FROM "public"."role" WHERE "id" = 3;

DELETE FROM "public"."role" WHERE "id" = 2;

DELETE FROM "public"."role" WHERE "id" = 1;

DROP TABLE "public"."event_history";


alter table "public"."webhook_event" drop constraint "webhook_event_webhook_id_fkey",
  add constraint "webhook_event_webhook_id_fkey"
  foreign key ("webhook_id")
  references "public"."webhook"
  ("id") on update restrict on delete no action;

alter table "public"."webhook" drop constraint "webhook_project_id_fkey",
  add constraint "webhook_project_id_fkey"
  foreign key ("project_id")
  references "public"."project"
  ("id") on update restrict on delete restrict;

CREATE TRIGGER "delete_webhook"
BEFORE DELETE ON "public"."webhook"
FOR EACH ROW EXECUTE FUNCTION before_webhook_deleted();

alter table "public"."webhook" drop constraint "webhook_project_id_fkey",
  add constraint "webhook_project_id_fkey"
  foreign key ("project_id")
  references "public"."project"
  ("id") on update restrict on delete no action;

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

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- CREATE TRIGGER delete_webhook
--    BEFORE DELETE ON webhook FOR EACH ROW
--    EXECUTE PROCEDURE before_webhook_deleted();

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- CREATE OR REPLACE FUNCTION before_webhook_deleted()
--     RETURNS trigger AS $BODY$
--     BEGIN
--         DELETE FROM public.webhook_event AS w WHERE w.event_id = OLD.id;
--     RETURN OLD;
--     END;
-- $BODY$ LANGUAGE plpgsql;

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- CREATE OR REPLACE FUNCTION on_new_project_added()
--     RETURNS trigger AS $BODY$
--     DECLARE
--         webhook_id_1 integer;
--         webhook_id_2 integer;
--         webhook_id_3 integer;
--         webhook_id_4 integer;
--         webhook_id_5 integer;
--         webhook_id_6 integer;
--         webhook_id_7 integer;
--         webhook_id_8 integer;
--     BEGIN
--
--     INSERT INTO public.environment (name, color_code, project_id) VALUES ('development', '#fff' ,NEW.id);
--     INSERT INTO public.environment (name, color_code, project_id) VALUES ('production', '#fff' ,NEW.id);
--
--     -- init new webhooks for this project, at the moment there're 8 different events
--     INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_1;
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (1, webhook_id_1);
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (2, webhook_id_1);
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (3, webhook_id_1);
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (4, webhook_id_1);
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (5, webhook_id_1);
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (6, webhook_id_1);
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (7, webhook_id_1);
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (8, webhook_id_1);
--
--
--
--     RETURN NEW;
--     END;
-- $BODY$ LANGUAGE plpgsql;

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- CREATE OR REPLACE FUNCTION on_new_project_added()
--     RETURNS trigger AS $BODY$
--     DECLARE
--         webhook_id_1 integer;
--         webhook_id_2 integer;
--         webhook_id_3 integer;
--         webhook_id_4 integer;
--         webhook_id_5 integer;
--         webhook_id_6 integer;
--         webhook_id_7 integer;
--         webhook_id_8 integer;
--     BEGIN
--
--     INSERT INTO public.environment (name, color_code, project_id) VALUES ('development', '#fff' ,NEW.id);
--     INSERT INTO public.environment (name, color_code, project_id) VALUES ('production', '#fff' ,NEW.id);
--
--     -- init new webhooks for this project, at the moment there're 8 different events
--     INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_1;
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (1, webhook_id_1);
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (1, webhook_id_1);
--
--
--
--
--
--     RETURN NEW;
--     END;
-- $BODY$ LANGUAGE plpgsql;

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- CREATE OR REPLACE FUNCTION on_new_project_added()
--     RETURNS trigger AS $BODY$
--     DECLARE
--         webhook_id_1 integer;
--         webhook_id_2 integer;
--         webhook_id_3 integer;
--         webhook_id_4 integer;
--         webhook_id_5 integer;
--         webhook_id_6 integer;
--         webhook_id_7 integer;
--         webhook_id_8 integer;
--     BEGIN
--
--     INSERT INTO public.environment (name, color_code, project_id) VALUES ('development', '#fff' ,NEW.id);
--     INSERT INTO public.environment (name, color_code, project_id) VALUES ('production', '#fff' ,NEW.id);
--
--     -- init new webhooks for this project, at the moment there're 8 different events
--     INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_1;
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (1, webhook_id_1);
--
--     INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_2;
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (2, webhook_id_2);
--
--     INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_3;
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (3, webhook_id_3);
--
--     INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_4;
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (4, webhook_id_4);
--
--     INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_5;
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (5, webhook_id_5);
--
--     INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_6;
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (6, webhook_id_6);
--
--     INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_7;
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (7, webhook_id_7);
--
--     INSERT INTO public.webhook (name, description, url, project_id) VALUES ('', '', '', NEW.id) RETURNING id INTO webhook_id_8;
--     INSERT INTO webhook_event (event_id, webhook_id) VALUES (8, webhook_id_8);
--
--
--
--     RETURN NEW;
--     END;
-- $BODY$ LANGUAGE plpgsql;


alter table "public"."webhook_event" drop constraint "webhook_event_webhook_id_fkey",
  add constraint "webhook_event_webhook_id_fkey"
  foreign key ("webhook_id")
  references "public"."webhook"
  ("id") on update restrict on delete restrict;

alter table "public"."webhook" drop constraint "webhook_project_id_fkey",
  add constraint "webhook_project_id_fkey"
  foreign key ("project_id")
  references "public"."project"
  ("id") on update restrict on delete restrict;

alter table "public"."environment" drop constraint "environment_project_id_fkey",
  add constraint "environment_project_id_fkey"
  foreign key ("project_id")
  references "public"."project"
  ("id") on update restrict on delete restrict;

DELETE FROM "public"."event" WHERE "id" = 8;

DELETE FROM "public"."event" WHERE "id" = 7;

DELETE FROM "public"."event" WHERE "id" = 6;

DELETE FROM "public"."event" WHERE "id" = 5;

DELETE FROM "public"."event" WHERE "id" = 4;

DELETE FROM "public"."event" WHERE "id" = 3;

DELETE FROM "public"."event" WHERE "id" = 2;

DELETE FROM "public"."event" WHERE "id" = 1;

DROP TABLE "public"."webhook_event";

DROP TABLE "public"."event";

DROP TABLE "public"."webhook";

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- CREATE TRIGGER insert_project AFTER INSERT  ON "project" FOR EACH ROW EXECUTE PROCEDURE on_new_project_added();

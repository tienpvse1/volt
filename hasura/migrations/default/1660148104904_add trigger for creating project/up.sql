CREATE OR REPLACE FUNCTION on_new_project_added()
    RETURNS trigger AS $BODY$
    BEGIN
    
    INSERT INTO public.environment (name, color_code, project_id) VALUES ('development', '#fff' ,NEW.id);
    INSERT INTO public.environment (name, color_code, project_id) VALUES ('production', '#fff' ,NEW.id);
    RETURN NEW;
    END;
$BODY$ LANGUAGE plpgsql;

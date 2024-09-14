DO $$
DECLARE
    state        TEXT;
    v_schema    VARCHAR(255):='&SCHEMA';
    v_banco     VARCHAR(255):='&BANCO';
    --Ao adicionar um usuario, incrementar
    v_usuarios  TEXT[]:= ARRAY[
                            &DEVS
                            ];

BEGIN

    RAISE NOTICE '--------------------------------------------------------------------------------------';
    RAISE NOTICE 'DAR TODAS AS PERMISSÕES NO PROJETO: %', UPPER(v_schema);
    RAISE NOTICE 'Executado em: %', now();
    RAISE NOTICE '--------------------------------------------------------------------------------------';

    RAISE NOTICE 'Usuários recebendo permissão total no banco % e no schema %', v_banco, v_schema;

    FOREACH state IN ARRAY v_usuarios
    LOOP

        EXECUTE FORMAT('GRANT CONNECT ON DATABASE %I TO %I', v_banco, state);
        EXECUTE FORMAT('GRANT USAGE ON SCHEMA "%I" TO %I', v_schema, state);
        EXECUTE FORMAT('ALTER DEFAULT PRIVILEGES IN SCHEMA "%I" GRANT SELECT ON TABLES TO %I', v_schema, state);
        EXECUTE FORMAT('GRANT SELECT,INSERT,UPDATE,DELETE ON ALL TABLES IN SCHEMA "%I" TO %I', v_schema, state);
        EXECUTE FORMAT('GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA "%I" TO %I', v_schema, state);
        EXECUTE FORMAT('GRANT SELECT ON ALL TABLES IN SCHEMA "%I" TO %I', v_schema, state);
        EXECUTE FORMAT('GRANT USAGE ON SCHEMA public TO %I', state);

        RAISE NOTICE 'Usuários  - %, permissao concedida', state;

    END LOOP;

END $$;
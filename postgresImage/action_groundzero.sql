DROP SCHEMA IF EXISTS action CASCADE;
DROP ROLE IF EXISTS actionsvc;

CREATE USER actionsvc PASSWORD 'actionsvc'
  NOSUPERUSER NOCREATEDB NOCREATEROLE NOREPLICATION INHERIT LOGIN;

CREATE SCHEMA action AUTHORIZATION actionsvc;

REVOKE ALL ON ALL TABLES IN SCHEMA action FROM PUBLIC;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA action FROM PUBLIC;
REVOKE CONNECT ON DATABASE postgres FROM PUBLIC;

GRANT CONNECT ON DATABASE postgres TO actionsvc;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA action TO actionsvc;
GRANT ALL ON ALL SEQUENCES IN SCHEMA action TO actionsvc;

-- create postgres extension to allow generation of v4 UUID
CREATE EXTENSION IF NOT EXISTS "pgcrypto";


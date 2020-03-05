-- After installing PostgreSQL 12...
-- As UNIX user postgres:

$ createdb pmnet
-- at the password prompt at the command below, type: dbuser
$ createuser -P dbuser

-- You can connect manually to the server, by typing this command (as any user):
-- psql -d pmnet -h 127.0.0.1 -U dbuser -W

-- As UNIX user postgres, do:
$ psql pmnet
> ALTER DEFAULT PRIVILEGES GRANT ALL ON TABLES TO dbuser
> ALTER DEFAULT PRIVILEGES GRANT ALL ON SEQUENCES TO dbuser

-- Login as dbuser with the psql command above, and type:

CREATE TABLE IF NOT EXISTS distro (
    id          BIGSERIAL                   NOT NULL,
    name        VARCHAR(255)                NOT NULL,

    PRIMARY KEY (id)
);
CREATE UNIQUE INDEX idx_n ON distro (name);

CREATE TABLE IF NOT EXISTS release (
    id          BIGSERIAL                   NOT NULL,
    author      VARCHAR(128)                NOT NULL,
    name        VARCHAR(255)                NOT NULL,
    version     VARCHAR(255)                NOT NULL,
    datetime    TIMESTAMP WITH TIME ZONE    NOT NULL,

    PRIMARY KEY (id)
);
CREATE UNIQUE INDEX idx_an ON release (author, name);

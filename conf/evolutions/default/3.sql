# --- !Ups

ALTER TABLE crawl_permission ADD granted_at timestamp;
ALTER TABLE crawl_permission ADD requested_at timestamp;
ALTER TABLE creator ADD last_login timestamp;
ALTER TABLE contact_person ALTER COLUMN email SET DATA TYPE varchar(255);
ALTER TABLE contact_person ADD CONSTRAINT uq_contact_person_email UNIQUE (email);
ALTER TABLE watched_target ADD archivist_notes_wt text;
ALTER TABLE target ADD second_language varchar(255);
ALTER TABLE instance ADD second_language varchar(255);
ALTER TABLE taxonomy ADD start_date timestamp;
ALTER TABLE taxonomy ADD end_date timestamp;

INSERT INTO taxonomy (ttype, id, url, created_at, name, description, updated_at)
    VALUES ('flags', 369, 'act-369', '2015-07-31 10:29:13.714', 'Video Content to add', 'This flag marks video content to add', '2015-07-31 10:29:13.714');


# --- !Downs

ALTER TABLE crawl_permission DROP granted_at;
ALTER TABLE crawl_permission DROP requested_at;
ALTER TABLE creator DROP last_login;
ALTER TABLE contact_person DROP CONSTRAINT uq_contact_person_email;
ALTER TABLE contact_person ALTER COLUMN email SET DATA TYPE text;
ALTER TABLE watched_target DROP archivist_notes_wt;
ALTER TABLE target DROP second_language;
ALTER TABLE instance DROP second_language;
ALTER TABLE taxonomy DROP start_date;
ALTER TABLE taxonomy DROP end_date;

DELETE FROM taxonomy WHERE ttype = 'flags' AND name = 'Video Content to add';

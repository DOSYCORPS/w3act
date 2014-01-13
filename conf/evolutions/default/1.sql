# --- Created by Ebean DDL
# To stop Ebean DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table dcollection (
  nid                       bigint not null,
  value                     TEXT,
  summary                   TEXT,
  format                    varchar(255),
  vid                       bigint,
  is_new                    boolean,
  type                      varchar(255),
  title                     varchar(255),
  language                  varchar(255),
  url                       varchar(255),
  edit_url                  varchar(255),
  status                    bigint,
  promote                   bigint,
  sticky                    bigint,
  created                   varchar(255),
  changed                   varchar(255),
  author                    varchar(255),
  log                       varchar(255),
  comment                   bigint,
  comment_count             bigint,
  comment_count_new         bigint,
  revision                  varchar(255),
  feed_nid                  bigint,
  field_targets             TEXT,
  field_sub_collections     TEXT,
  field_instances           TEXT,
  weight                    bigint,
  node_count                bigint,
  vocabulary                TEXT,
  parent                    TEXT,
  parents_all               TEXT,
  constraint pk_dcollection primary key (nid))
;

create table instance (
  nid                       bigint not null,
  value                     TEXT,
  summary                   TEXT,
  act_url                   varchar(255),
  wct_url                   varchar(255),
  format                    varchar(255),
  field_scope               varchar(255),
  field_depth               varchar(255),
  field_via_correspondence  varchar(255),
  field_uk_postal_address   varchar(255),
  field_uk_hosting          varchar(255),
  field_nominating_organisation varchar(255),
  field_crawl_frequency     varchar(255),
  field_crawl_start_date    varchar(255),
  field_uk_domain           boolean,
  field_crawl_permission    varchar(255),
  field_special_dispensation varchar(255),
  field_uk_geoip            boolean,
  field_professional_judgement varchar(255),
  vid                       bigint,
  is_new                    boolean,
  type                      varchar(255),
  title                     varchar(255),
  language                  varchar(255),
  url                       varchar(255),
  edit_url                  varchar(255),
  status                    bigint,
  promote                   bigint,
  sticky                    bigint,
  created                   varchar(255),
  changed                   varchar(255),
  author                    varchar(255),
  log                       varchar(255),
  comment                   bigint,
  comment_count             bigint,
  comment_count_new         bigint,
  feed_nid                  bigint,
  field_crawl_end_date      varchar(255),
  field_live_site_status    varchar(255),
  field_wct_id              bigint,
  field_spt_id              bigint,
  field_no_ld_criteria_met  boolean,
  field_key_site            varchar(255),
  field_professional_judgement_exp TEXT,
  field_ignore_robots_txt   varchar(255),
  revision                  varchar(255),
  field_url                 TEXT,
  field_description         TEXT,
  field_uk_postal_address_url TEXT,
  field_suggested_collections TEXT,
  field_collections         TEXT,
  field_license             TEXT,
  field_collection_categories TEXT,
  field_notes               TEXT,
  field_instances           TEXT,
  field_subject             TEXT,
  constraint pk_instance primary key (nid))
;

create table organisation (
  nid                       bigint not null,
  value                     TEXT,
  summary                   varchar(255),
  format                    varchar(255),
  field_abbreviation        varchar(255),
  vid                       bigint,
  is_new                    boolean,
  type                      varchar(255),
  title                     varchar(255),
  language                  varchar(255),
  url                       varchar(255),
  edit_url                  varchar(255),
  status                    bigint,
  promote                   bigint,
  sticky                    bigint,
  created                   varchar(255),
  changed                   varchar(255),
  author                    varchar(255),
  log                       varchar(255),
  comment                   bigint,
  comment_count             bigint,
  comment_count_new         bigint,
  revision                  TEXT,
  feed_nid                  bigint,
  last_update               timestamp not null,
  constraint pk_organisation primary key (nid))
;

create table permission (
  id                        bigint not null,
  name                      TEXT,
  url                       TEXT,
  description               TEXT,
  revision                  TEXT,
  last_update               timestamp not null,
  constraint pk_permission primary key (id))
;

create table role (
  id                        bigint not null,
  name                      TEXT,
  url                       TEXT,
  permissions               TEXT,
  description               TEXT,
  revision                  TEXT,
  last_update               timestamp not null,
  constraint pk_role primary key (id))
;

create table target (
  nid                       bigint not null,
  value                     TEXT,
  summary                   TEXT,
  format                    varchar(255),
  field_scope               varchar(255),
  field_depth               varchar(255),
  field_via_correspondence  boolean,
  field_uk_postal_address   boolean,
  field_uk_hosting          boolean,
  field_nominating_organisation varchar(255),
  field_crawl_frequency     varchar(255),
  field_crawl_start_date    varchar(255),
  field_uk_domain           boolean,
  field_crawl_permission    varchar(255),
  field_special_dispensation boolean,
  field_uk_geoip            boolean,
  field_professional_judgement boolean,
  vid                       bigint,
  is_new                    boolean,
  type                      varchar(255),
  title                     varchar(255),
  language                  varchar(255),
  url                       varchar(255),
  edit_url                  varchar(255),
  status                    bigint,
  promote                   bigint,
  sticky                    bigint,
  created                   varchar(255),
  changed                   varchar(255),
  author                    varchar(255),
  log                       varchar(255),
  comment                   bigint,
  comment_count             bigint,
  comment_count_new         bigint,
  feed_nid                  bigint,
  field_crawl_end_date      varchar(255),
  field_live_site_status    varchar(255),
  field_wct_id              bigint,
  field_spt_id              bigint,
  field_no_ld_criteria_met  boolean,
  field_key_site            boolean,
  field_professional_judgement_exp TEXT,
  field_ignore_robots_txt   boolean,
  revision                  TEXT,
  active                    boolean,
  white_list                varchar(255),
  black_list                varchar(255),
  field_url                 TEXT,
  field_description         TEXT,
  field_uk_postal_address_url TEXT,
  field_suggested_collections TEXT,
  field_collections         TEXT,
  field_license             TEXT,
  field_collection_categories TEXT,
  field_notes               TEXT,
  field_instances           TEXT,
  field_subject             TEXT,
  keywords                  TEXT,
  synonyms                  TEXT,
  last_update               timestamp not null,
  constraint pk_target primary key (nid))
;

create table taxonomy (
  tid                       bigint not null,
  name                      varchar(255),
  type                      varchar(255),
  description               TEXT,
  weight                    bigint,
  node_count                bigint,
  url                       TEXT,
  vocabulary                TEXT,
  feed_nid                  bigint,
  field_owner               TEXT,
  parent                    TEXT,
  parents_all               TEXT,
  constraint pk_taxonomy primary key (tid))
;

create table taxonomy_vocabulary (
  vid                       bigint not null,
  name                      varchar(255),
  machine_name              varchar(255),
  description               TEXT,
  term_count                bigint,
  constraint pk_taxonomy_vocabulary primary key (vid))
;

create table creator (
  email                     varchar(255) not null,
  name                      varchar(255),
  password                  varchar(255),
  field_affiliation         varchar(255),
  uid                       bigint,
  url                       varchar(255),
  edit_url                  varchar(255),
  last_access               varchar(255),
  last_login                varchar(255),
  created                   varchar(255),
  status                    bigint,
  language                  varchar(255),
  feed_nid                  bigint,
  roles                     TEXT,
  revision                  TEXT,
  last_update               timestamp not null,
  constraint pk_creator primary key (email))
;

create sequence dcollection_seq;

create sequence instance_seq;

create sequence organisation_seq;

create sequence permission_seq;

create sequence role_seq;

create sequence target_seq;

create sequence taxonomy_seq;

create sequence taxonomy_vocabulary_seq;

create sequence creator_seq;




# --- !Downs

drop table if exists dcollection cascade;

drop table if exists instance cascade;

drop table if exists organisation cascade;

drop table if exists permission cascade;

drop table if exists role cascade;

drop table if exists target cascade;

drop table if exists taxonomy cascade;

drop table if exists taxonomy_vocabulary cascade;

drop table if exists creator cascade;

drop sequence if exists dcollection_seq;

drop sequence if exists instance_seq;

drop sequence if exists organisation_seq;

drop sequence if exists permission_seq;

drop sequence if exists role_seq;

drop sequence if exists target_seq;

drop sequence if exists taxonomy_seq;

drop sequence if exists taxonomy_vocabulary_seq;

drop sequence if exists creator_seq;

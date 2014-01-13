#!/bin/bash

rm -rf target/ project/target/ project/project/target/
echo Project generated folders clean up completed. 

# postgres setup:
# su - postgres -c "createuser --superuser --password training"
psql -d w3act -U training -f cleanupDB.sql
su - postgres -c "dropdb w3act"
su - postgres -c "createdb --owner=training --username=training w3act"
su - postgres -c "psql -c 'grant all on database w3act to training'"
echo PostgreSQL schema clean up completed. 

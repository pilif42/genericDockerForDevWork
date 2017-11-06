FROM postgres:9.6.3
ENV POSTGRES_DB postgres 
ENV POSTGRES_USER postgres

# To add a script that will be run when the container is started because it is in docker-entrypoint-initdb.d
ADD action_groundzero.sql /docker-entrypoint-initdb.d/action_groundzero.sql
RUN chmod 755 /docker-entrypoint-initdb.d/action_groundzero.sql

# To add a script that will be run manually once the container is started.
# How to run it manually: for instance, see the shell script in commented-out lines below
# docker-compose -f docker-compose-dev_env.yml down
# docker-compose -f docker-compose-dev_env.yml up -d
# sleep 20
# docker exec postgres psql -U postgres -d postgres -f action_test_data.sql
ADD action_test_data.sql /action_test_data.sql
RUN chmod 755 /action_test_data.sql

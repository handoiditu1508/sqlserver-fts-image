FROM mcr.microsoft.com/mssql/server:2022-latest

USER root

# Install dependencies - these are required to make changes to apt-get below
RUN apt-get update && \
    apt-get install -yq gnupg gnupg2 gnupg1 curl apt-transport-https && \
# Install SQL Server package links
    curl https://packages.microsoft.com/keys/microsoft.asc -o /var/opt/mssql/ms-key.cer && \
    apt-key add /var/opt/mssql/ms-key.cer && \
    curl https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list -o /etc/apt/sources.list.d/mssql-server-2022.list && \
    apt-get update && \
# Install SQL Server full-text-search
    apt-get install -y mssql-server-fts && \
# Cleanup
    apt-get clean && \
    rm -rf /var/lib/apt/lists

# Run SQL Server process
ENTRYPOINT ["/opt/mssql/bin/sqlservr"]

# reference:
# https://tedspence.com/a-sql-server-docker-container-with-full-text-search-a1b7c5fc308c

# commands:
# docker buildx build -t handoiditu1508/sql-fts:2022-latest .
# docker run --name sql-fts --rm -p 1433:1433 --env ACCEPT_EULA=Y --env MSSQL_SA_PASSWORD=P@zzvv0rd handoiditu1508/sql-fts:2022-latest
# docker push handoiditu1508/sql-fts:2022-latest

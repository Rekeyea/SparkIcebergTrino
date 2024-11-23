FROM apache/hive:3.1.3

USER root

# Install required packages
RUN apt-get update && \
    apt-get install -y wget netcat-traditional && \
    wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.27/mysql-connector-java-8.0.27.jar -O /opt/hive/lib/mysql-connector-java.jar && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy schema SQL files to a known location
RUN mkdir -p /opt/hive/scripts/schemas && \
    cp /opt/hive/scripts/metastore/upgrade/mysql/hive-schema-* /opt/hive/scripts/schemas/ || true

# Switch back to hive user
USER hive
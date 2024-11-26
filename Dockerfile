FROM jupyter/pyspark-notebook:latest
USER root

# Install wget
RUN apt-get update && apt-get install -y wget

# Download dependencies
RUN cd /usr/local/spark/jars && \
    wget "https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.4_2.12/1.4.2/iceberg-spark-runtime-3.4_2.12-1.4.2.jar" -O iceberg-spark-runtime-3.4_2.12-1.4.2.jar &&\
    wget "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar" -O hadoop-aws-3.3.4.jar &&\
    wget "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.3.4/hadoop-common-3.3.4.jar" -O hadoop-common-3.3.4.jar &&\
    wget "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-client-api/3.3.4/hadoop-client-api-3.3.4.jar" -O hadoop-client-api-3.3.4.jar &&\
    wget "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-client-runtime/3.3.4/hadoop-client-runtime-3.3.4.jar" -O hadoop-client-runtime-3.3.4.jar &&\
    wget "https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.261/aws-java-sdk-bundle-1.12.261.jar" -O aws-java-sdk-bundle-1.12.261.jar &&\
    wget "https://repo1.maven.org/maven2/org/apache/hive/hive-metastore/3.1.3/hive-metastore-3.1.3.jar" -O hive-metastore-3.1.3.jar &&\
    wget "https://repo1.maven.org/maven2/org/apache/hive/hive-exec/3.1.3/hive-exec-3.1.3.jar" -O hive-exec-3.1.3.jar &&\
    wget "https://repo1.maven.org/maven2/org/apache/hive/hive-common/3.1.3/hive-common-3.1.3.jar" -O hive-common-3.1.3.jar &&\
    wget "https://repo1.maven.org/maven2/org/apache/parquet/parquet-hadoop-bundle/1.12.3/parquet-hadoop-bundle-1.12.3.jar" -O parquet-hadoop-bundle-1.12.3.jar &&\
    wget "https://repo1.maven.org/maven2/org/apache/orc/orc-core/1.9.1/orc-core-1.9.1.jar" -O orc-core-1.9.1.jar

USER ${NB_UID}
FROM jupyter/pyspark-notebook:latest
USER root

# Install wget
RUN apt-get update && apt-get install -y wget

# Download dependencies
RUN cd /usr/local/spark/jars && \
    wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.4_2.12/1.4.2/iceberg-spark-runtime-3.4_2.12-1.4.2.jar && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar && \
    wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.261/aws-java-sdk-bundle-1.12.261.jar && \
    wget https://jdbc.postgresql.org/download/postgresql-42.7.1.jar && \
    wget https://repo1.maven.org/maven2/org/apache/parquet/parquet-hadoop-bundle/1.12.3/parquet-hadoop-bundle-1.12.3.jar && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.3.4/hadoop-common-3.3.4.jar

USER ${NB_UID}
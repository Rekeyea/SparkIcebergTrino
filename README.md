from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("IcebergApp") \
    .config("spark.jars.packages", "org.apache.iceberg:iceberg-spark-runtime-3.4_2.12:1.4.2") \
    .config("spark.sql.extensions", "org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions") \
    .config("spark.sql.catalog.spark_catalog", "org.apache.iceberg.spark.SparkSessionCatalog") \
    .config("spark.sql.catalog.spark_catalog.type", "hive") \
    .config("spark.sql.catalog.spark_catalog.uri", "thrift://hive-metastore:9083") \
    .config("spark.sql.catalog.hadoop_prod", "org.apache.iceberg.spark.SparkCatalog") \
    .config("spark.sql.catalog.hadoop_prod.type", "hadoop") \
    .config("spark.sql.catalog.hadoop_prod.warehouse", "s3a://datalake/warehouse") \
    .config("spark.sql.defaultCatalog", "hadoop_prod") \
    .config("spark.hadoop.fs.s3a.endpoint", "http://minio:9000") \
    .config("spark.hadoop.fs.s3a.access.key", "minio") \
    .config("spark.hadoop.fs.s3a.secret.key", "minio123") \
    .config("spark.hadoop.fs.s3a.path.style.access", "true") \
    .config("spark.hadoop.fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem") \
    .config("spark.hadoop.fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider") \
    .enableHiveSupport() \
    .getOrCreate()

spark.sql("DROP TABLE IF EXISTS hadoop_prod.testdb.test_table").show()

spark.sql("CREATE DATABASE IF NOT EXISTS hadoop_prod.testdb").show()

# Create new table
spark.sql("""
    CREATE TABLE hadoop_prod.testdb.test_table (
        id bigint,
        data string)
    USING iceberg
""").show()

# Insert data using SQL
spark.sql("""
    INSERT INTO hadoop_prod.testdb.test_table
    VALUES 
        (1, 'data1'),
        (2, 'data2'),
        (3, 'data3')
""")
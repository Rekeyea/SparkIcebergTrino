from pyspark.sql import SparkSession

packages = [
    # Iceberg
    "org.apache.iceberg:iceberg-spark-runtime-3.4_2.12:1.4.2",
    
    # AWS & Hadoop
    "org.apache.hadoop:hadoop-aws:3.3.4",
    "org.apache.hadoop:hadoop-common:3.3.4",
    "org.apache.hadoop:hadoop-client-api:3.3.4",
    "org.apache.hadoop:hadoop-client-runtime:3.3.4",
    "com.amazonaws:aws-java-sdk-bundle:1.12.261",
    
    # Hive Metastore EMR version
    "org.apache.hive:hive-metastore:3.1.2",
    "org.apache.hive:hive-exec:3.1.2",
    "org.apache.hive:hive-common:3.1.2",
    
    # Data formats
    "org.apache.parquet:parquet-hadoop-bundle:1.12.3",
    "org.apache.orc:orc-core:1.9.1"
]

spark = SparkSession.builder \
    .appName("IcebergApp") \
    .config("spark.jars.packages", ",".join(packages)) \
    .config("spark.sql.extensions", "org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions") \
    .config("spark.sql.catalogImplementation", "hive") \
    .config("spark.sql.catalog.iceberg", "org.apache.iceberg.spark.SparkCatalog") \
    .config("spark.sql.catalog.iceberg.type", "hive") \
    .config("spark.sql.catalog.iceberg.uri", "thrift://hive-metastore:9083") \
    .config("spark.sql.catalog.iceberg.warehouse", "s3a://datalake/warehouse") \
    .config("spark.sql.warehouse.dir", "s3a://datalake/warehouse") \
    .config("spark.hadoop.hive.metastore.warehouse.dir", "s3a://datalake/warehouse") \
    \
    .config("spark.sql.catalog.iceberg.s3.endpoint", "http://minio:9000") \
    .config("spark.sql.catalog.iceberg.s3.access-key-id", "minio") \
    .config("spark.sql.catalog.iceberg.s3.secret-access-key", "minio123") \
    .config("spark.sql.catalog.iceberg.s3.path-style-access", "true") \
    \
    .config("spark.hadoop.fs.s3a.endpoint", "http://minio:9000") \
    .config("spark.hadoop.fs.s3a.access.key", "minio") \
    .config("spark.hadoop.fs.s3a.secret.key", "minio123") \
    .config("spark.hadoop.fs.s3a.path.style.access", "true") \
    .config("spark.hadoop.fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem") \
    .config("spark.hadoop.fs.s3a.connection.ssl.enabled", "false") \
    \
    .config("spark.hadoop.fs.s3a.connection.maximum", "100") \
    .config("spark.hadoop.fs.s3a.connection.timeout", "200000") \
    .config("spark.hadoop.fs.s3a.attempts.maximum", "20") \
    .config("spark.hadoop.fs.s3a.connection.establish.timeout", "5000") \
    .config("spark.hadoop.fs.s3a.fast.upload", "true") \
    .config("spark.hadoop.fs.s3a.fast.upload.buffer", "bytebuffer") \
    .config("spark.hadoop.fs.s3a.multipart.size", "10485760") \
    \
    .enableHiveSupport() \
    .getOrCreate()

# Create new table
spark.sql("""
    CREATE TABLE iceberg.testdb.test_table (
        id bigint,
        data string)
    USING iceberg
""").show()

# Insert data using SQL
spark.sql("""
    INSERT INTO iceberg.testdb.test_table
    VALUES 
        (1, 'data1'),
        (2, 'data2'),
        (3, 'data3')
""").show()

spark.sql("""
    SELECT * FROM iceberg.testdb.test_table
""").show()
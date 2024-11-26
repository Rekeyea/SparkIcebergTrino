```python
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("IcebergApp") \
    .config("spark.jars.dir", "/usr/local/spark/jars") \
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
```

```python
# Create Database
spark.sql("CREATE DATABASE iceberg.testdb").show()
```

```python
# Create new table
spark.sql("""
    CREATE TABLE iceberg.testdb.test_table (
        id bigint,
        data string)
    USING iceberg
""").show()
```

```python
# Insert data using SQL
spark.sql("""
    INSERT INTO iceberg.testdb.test_table
    VALUES 
        (1, 'data1'),
        (2, 'data2'),
        (3, 'data3')
""").show()
```

```python
# Query Data
spark.sql("""
    SELECT * FROM iceberg.testdb.test_table
""").show()
```
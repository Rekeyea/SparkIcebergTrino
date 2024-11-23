CREATE CATALOG iceberg_catalog USING iceberg
WITH (
    "hive.metastore.uri" = 'thrift://hms:9083',
    "hive.metastore-refresh-interval" = '1m',
    "hive.metastore-timeout" = '10s',
    "iceberg.file-format" = 'PARQUET',
    "iceberg.compression-codec" = 'SNAPPY'
);
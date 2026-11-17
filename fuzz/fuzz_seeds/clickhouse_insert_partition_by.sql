INSERT INTO FUNCTION s3(export_config, filename = '_test/{_partition_id}/year/2026/month/11/day/16/hour/20/part-0000.parquet')
  PARTITION BY concat(
      'system_id/',  ifNull(attrs.systemid::Nullable(String), 'unknown'),
      '/service/',   ifNull(attrs.c2cService::Nullable(String), 'unknown'),
      '/partition/', ifNull(attrs.c2cPartition::Nullable(String), 'unknown'),
      '/stage/',     ifNull(attrs.c2cStage::Nullable(String), 'unknown'))
  SELECT Timestamp::DateTime64(9) AS timestamp,
         line.level::Nullable(String) AS level,
         toJSONString(__raw_data) AS raw
  FROM events
  WHERE attrs.systemid = 'checkout-api'
    AND attrs.c2cStage = 'development'
    AND Timestamp >= '2026-11-16 20:00:00'
    AND Timestamp < '2026-11-16 20:05:00'
  SETTINGS max_execution_time = 500, output_format_parquet_compression_method = 'zstd', s3_truncate_on_insert = 1;

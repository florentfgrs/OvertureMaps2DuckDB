LOAD SPATIAL ; LOAD httpfs ; 
CREATE TABLE places as 
SELECT
    *,
    ST_GeomFromWKB(geometry) as geometry
FROM read_parquet('s3://overturemaps-us-west-2/release/{millesime}/theme=places/type=*/*', filename=true, hive_partitioning=1)
WHERE 
 bbox.xmin > {xmin}
AND bbox.xmax < {xmax}
AND bbox.ymin > {ymin}
AND bbox.ymax < {ymax} ; 
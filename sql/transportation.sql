LOAD SPATIAL ; LOAD httpfs ; 
DROP TABLE IF EXISTS transportation_connector ; 
CREATE TABLE transportation_connector as 
SELECT
id,
version, 
update_time,
sources[1].dataset as sources_dataset,
sources[1].record_id as sources_id,
sources[1].confidence as sources_confidence,
sources::varchar as sources, 
subtype,
names.primary as primary_name, 
names::varchar as names, 
class, 
connector_ids::varchar as connector_ids,
road,
type,
ST_GeomFromWKB(geometry) as geom
FROM read_parquet('s3://overturemaps-us-west-2/release/{millesime}/theme=transportation/type=*/*', filename=true, hive_partitioning=1)
WHERE 
 bbox.xmin > {xmin}
AND bbox.xmax < {xmax}
AND bbox.ymin > {ymin}
AND bbox.ymax < {ymax}
AND st_geometrytype(ST_GeomFromWKB(geometry)) = 'POINT' ; 

DROP TABLE IF EXISTS transportation_segment ; 
CREATE TABLE transportation_segment as 
SELECT
id,
version, 
update_time,
sources[1].dataset as sources_dataset,
sources[1].record_id as sources_id,
sources[1].confidence as sources_confidence,
sources::varchar as sources, 
subtype,
names.primary as primary_name, 
names::varchar as names, 
class, 
connector_ids::varchar as connector_ids,
road,
type,
ST_GeomFromWKB(geometry) as geom
FROM read_parquet('s3://overturemaps-us-west-2/release/{millesime}/theme=transportation/type=*/*', filename=true, hive_partitioning=1)
WHERE 
 bbox.xmin > {xmin}
AND bbox.xmax < {xmax}
AND bbox.ymin > {ymin}
AND bbox.ymax < {ymax}
AND st_geometrytype(ST_GeomFromWKB(geometry)) = 'LINESTRING' ; 
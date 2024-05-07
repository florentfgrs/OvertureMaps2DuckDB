LOAD SPATIAL ; LOAD httpfs ; 
DROP TABLE IF EXISTS admins_polygon ; 
CREATE TABLE admins_polygon as 
SELECT
id, 
names.primary as primary_name, names::varchar as names, 
admin_level,
is_maritime,
geopol_display,
version,
update_time, 
sources[1].dataset as sources_dataset,
sources[1].record_id as sources_id,
sources[1].confidence as sources_confidence,
subtype,
locality_type,
wikidata,
context_id,
population,
iso_country_code_alpha_2,
iso_sub_country_code,
default_language,
driving_side,
locality_id,
type,
ST_GeomFromWKB(geometry) as geom
FROM read_parquet('s3://overturemaps-us-west-2/release/{millesime}/theme=admins/type=*/*', filename=true, hive_partitioning=1)
WHERE 
 bbox.xmin > {xmin}
AND bbox.xmax < {xmax}
AND bbox.ymin > {ymin}
AND bbox.ymax < {ymax}
AND st_geometrytype(ST_GeomFromWKB(geometry)) = 'MULTIPOLYGON'

UNION 

SELECT
id, 
names.primary as primary_name, names::varchar as names, 
admin_level,
is_maritime,
geopol_display,
version,
update_time, 
sources[1].dataset as sources_dataset,
sources[1].record_id as sources_id,
sources[1].confidence as sources_confidence,
subtype,
locality_type,
wikidata,
context_id,
population,
iso_country_code_alpha_2,
iso_sub_country_code,
default_language,
driving_side,
locality_id,
type,
ST_GeomFromText(replace(st_astext(ST_GeomFromWKB(geometry)), 'POLYGON ((', 'MULTIPOLYGON (((')||')') as geom
FROM read_parquet('s3://overturemaps-us-west-2/release/{millesime}/theme=admins/type=*/*', filename=true, hive_partitioning=1)
WHERE 
 bbox.xmin > {xmin}
AND bbox.xmax < {xmax}
AND bbox.ymin > {ymin}
AND bbox.ymax < {ymax}
AND st_geometrytype(ST_GeomFromWKB(geometry)) = 'POLYGON'; 

DROP TABLE IF EXISTS admins_point ; 
CREATE TABLE admins_point as 
SELECT
id, 
names.primary as primary_name, names::varchar as names, 
admin_level,
is_maritime,
geopol_display,
version,
update_time, 
sources[1].dataset as sources_dataset,
sources[1].record_id as sources_id,
sources[1].confidence as sources_confidence,
subtype,
locality_type,
wikidata,
context_id,
population,
iso_country_code_alpha_2,
iso_sub_country_code,
default_language,
driving_side,
locality_id,
type,
ST_GeomFromWKB(geometry) as geom
FROM read_parquet('s3://overturemaps-us-west-2/release/{millesime}/theme=admins/type=*/*', filename=true, hive_partitioning=1)
WHERE 
 bbox.xmin > {xmin}
AND bbox.xmax < {xmax}
AND bbox.ymin > {ymin}
AND bbox.ymax < {ymax}
AND st_geometrytype(ST_GeomFromWKB(geometry)) = 'POINT' ; 

-- DROP TABLE IF EXISTS admins_linestring ; 
-- CREATE TABLE admins_linestring as 
-- SELECT
-- id, 
-- names.primary as primary_name, names::varchar as names, 
-- admin_level,
-- is_maritime,
-- geopol_display,
-- version,
-- update_time, 
-- sources[1].dataset as sources_dataset,
-- sources[1].record_id as sources_id,
-- sources[1].confidence as sources_confidence,
-- subtype,
-- locality_type,
-- wikidata,
-- context_id,
-- population,
-- iso_country_code_alpha_2,
-- iso_sub_country_code,
-- default_language,
-- driving_side,
-- locality_id,
-- ST_GeomFromWKB(geometry) as geom
-- FROM read_parquet('s3://overturemaps-us-west-2/release/{millesime}/theme=admins/type=*/*', filename=true, hive_partitioning=1)
-- WHERE 
--  bbox.xmin > {xmin}
-- AND bbox.xmax < {xmax}
-- AND bbox.ymin > {ymin}
-- AND bbox.ymax < {ymax}
-- AND st_geometrytype(ST_GeomFromWKB(geometry)) = 'LINESTRING' ; 
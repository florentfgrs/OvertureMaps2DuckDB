LOAD SPATIAL ; LOAD httpfs ; 
DROP TABLE IF EXISTS buildings ; 
CREATE TABLE buildings as 
SELECT
id, 
update_time,
sources[1] as sources,
names.primary as primary_names,
level,
height,
num_floors,
min_height,
min_floor,
facade_color,
facade_material,
roof_material,
roof_shape,
roof_direction,
roof_orientation,
roof_color,
ST_GeomFromWKB(geometry) as geom
FROM read_parquet('s3://overturemaps-us-west-2/release/{millesime}/theme=buildings/type=*/*',
filename=true,
hive_partitioning=1)
WHERE 
 bbox.xmin > {xmin}
AND bbox.xmax < {xmax}
AND bbox.ymin > {ymin}
AND bbox.ymax < {ymax} ; 
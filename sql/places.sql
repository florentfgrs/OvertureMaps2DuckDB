LOAD SPATIAL ; LOAD httpfs ; 
DROP TABLE IF EXISTS places ; 
CREATE TABLE places as 
SELECT
    id, 
    update_time,
    names.primary as primary_name,
    categories.main as categories_main,
    confidence, 
    websites[1] as websites, 
    emails[1] as emails, 
    phones[1] as phones,
    brand.wikidata as brand_wikidata, 
    (brand.names).primary as brand_names, 
    addresses[1].freeform as addresses,
    addresses[1].locality as locality,
    addresses[1].postcode as postcode,
    addresses[1].region as region,
    addresses[1].country as country, 
    filename, 
    theme, 
    type,
    --ST_GeomFromWKB(geometry) as geometry : with this, all my geoms are 'POINT (0 0)'
    ST_Point(bbox.xmin, bbox.ymin) as geometry
FROM read_parquet('s3://overturemaps-us-west-2/release/{millesime}/theme=places/type=*/*', filename=true, hive_partitioning=1)
WHERE 
bbox.xmin > {xmin}
AND bbox.xmax < {xmax}
AND bbox.ymin > {ymin}
AND bbox.ymax < {ymax} ; 
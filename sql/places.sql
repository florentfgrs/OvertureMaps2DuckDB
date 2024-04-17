LOAD SPATIAL ; LOAD httpfs ; 
CREATE TABLE places as 
SELECT
    id, 
    update_time,
    names.primary as primary_name,
    categories.main as categories_main,
    confidence, 
    websites, 
    emails, 
    phones,
    brand.wikidata as brand_wikidata, 
    (brand.names).primary as brand_names, 
    addresses.freeform as addresses,
    addresses.locality as locality,
    addresses.postcode as postcode,
    addresses.region as region,
    addresses.country as country, 
    filename, 
    theme, 
    type, 
    geometry
FROM read_parquet('s3://overturemaps-us-west-2/release/{millesime}/theme=places/type=*/*', filename=true, hive_partitioning=1)
WHERE 
 bbox.xmin > {xmin}
AND bbox.xmax < {xmax}
AND bbox.ymin > {ymin}
AND bbox.ymax < {ymax} ; 
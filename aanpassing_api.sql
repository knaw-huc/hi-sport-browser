
CREATE SCHEMA api;



CREATE MATERIALIZED VIEW api.vereniging AS
    SELECT *
    FROM public.vereniging_vereniging
    JOIN (select vereniging,array_agg(soort_sport) as sporten from vereniging_sport group by vereniging) AS soort_sport
     ON soort_sport.vereniging = vereniging_vereniging.id
    ORDER BY naam;

CREATE MATERIALIZED VIEW api.literatuur AS
    SELECT *
    FROM public.vereniging_literatuur
    ORDER BY auteur;

CREATE MATERIALIZED VIEW api.landelijke_bond AS
    SELECT *
    FROM public."vereniging_Landelijke_bond"
    ORDER BY naam;

CREATE MATERIALIZED VIEW api.regionale_bond AS
    SELECT *
    FROM public."vereniging_Regionale_bond"
    ORDER BY naam;

CREATE MATERIALIZED VIEW api.publicaties AS
    SELECT *
    FROM public.vereniging_publicaties
    ORDER BY title;

CREATE ROLE sport LOGIN;
CREATE ROLE view_api NOLOGIN;

GRANT USAGE ON SCHEMA api TO view_api;
GRANT SELECT ON api.vereniging TO view_api;
GRANT SELECT ON api.landelijke_bond TO view_api;
GRANT SELECT ON api.regionale_bond TO view_api;
GRANT SELECT ON api.literatuur TO view_api;
GRANT SELECT ON api.publicaties TO view_api;

GRANT view_api TO sport;


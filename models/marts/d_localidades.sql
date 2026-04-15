with
    localidades as (
        select distinct
            city
            , stateprovince_name as estado
            , countryregion_name as pais
        from {{ ref('int_cliente') }}
        where city is not null
    )
select
    {{
        dbt_utils.generate_surrogate_key(
            [
                "coalesce(city, '')"
                , "coalesce(estado, '')"
                , "coalesce(pais, '')"
            ]
        )
    }} as sk_localidade
    , city as cidade
    , estado
    , pais
from localidades

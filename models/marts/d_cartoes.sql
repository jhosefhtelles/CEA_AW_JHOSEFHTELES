select
    {{ dbt_utils.generate_surrogate_key(['cast(creditcardid as string)']) }} as sk_cartao
    , creditcardid
    , cardtype as tipo_cartao
from {{ ref('stg_credit_card') }}

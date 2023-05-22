select 
        channel, 
        sum(pa.spend)/nullif(sum(pa.clicks),0)  as cpc
    from {{ ref('paid_ads') }} as pa 
group by channel
order by channel


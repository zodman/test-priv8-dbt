select 
        channel, 
        sum(pa.impressions)  as impressions
    from {{ ref('paid_ads') }} as pa 
group by channel

order by channel

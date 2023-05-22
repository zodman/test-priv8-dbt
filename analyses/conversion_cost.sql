select 
        channel, 
        sum(pa.spend)/nullif(sum(pa.total_conversions),0)  as cost_conversion
    from {{ ref('paid_ads') }} as pa 
    
group by channel
order by channel

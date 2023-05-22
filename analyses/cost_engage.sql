select 
        channel, 
        sum(pa.spend)/nullif(sum(pa.engagements),0)::float  as cost_engage
    from {{ ref('paid_ads') }} as pa 
group by channel

order by channel

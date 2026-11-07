with

input(content) as (
    select content.rtrim(e'\n')
    from read_text('{{ file }}')
),

banks as (
    from (
        from input
        select
            generate_subscripts(content.split(e'\n'), 1) as bank_id,
            unnest(content.split(e'\n')) as bank,
    )
    select
        bank_id,
        generate_subscripts(bank.split(''), 1) as battery_id,
        unnest(bank.split('')) as battery,
),

joltage as (
    select
        bank_id,
        battery_id,
        battery,
        concat(
            max(battery) over (
                partition by bank_id
                order by battery_id
                rows between unbounded preceding and 1 preceding
            ),
            battery
        )::int as joltage
    from banks
),

max_joltage as (
    select bank_id, max(joltage) as max_joltage
    from joltage
    group by bank_id
)

select sum(max_joltage) as total_output_joltage
from max_joltage
;

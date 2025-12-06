with

input(content) as (
    select content.rtrim(e'\n')
    from read_text('advent_of_code/solutions/year_2020/day_01/sample.data')
)

from input
;

with

input(content) as (
    select content.rtrim(e'\n')
    from read_text('advent_of_code/solutions/year_{{ year }}/day_{{ "%02d" % day }}/sample.data')
)

from input
;

with recursive

input(content) as (
    select content.rtrim(e'\n').replace(' ', ' ')
    from read_text('{{ file }}')
),

lines as (
    from (
        from input
        select
            generate_subscripts(content.split(e'\n'), 1) as line_id,
            unnest(content.split(e'\n')) as line,
    )
    select
        line_id,
        max(line_id) over () as max_line_id,
        generate_subscripts(line.split(''), 1) as char_id,
        unnest(line.split('')) as char,
),

problem_ids as (
    select
        line_id,
        char_id,
        sum(char != ' ') over by_char_id as problem_id,
        last_value(char.nullif(' ') ignore nulls) over by_char_id as operator,
    from lines
    where line_id = max_line_id
    window by_char_id as (order by char_id)
),

problem_metadata as (
    from (
        select
            problem_ids.problem_id,
            problem_ids.operator,
            lines.line_id,
            /* Reset the character ID for each problem */
            row_number() over (
                partition by problem_ids.problem_id, lines.line_id
                order by lines.char_id
            ) as char_id,
            lines.char,
        from lines
            inner join problem_ids
                using (char_id)
        where lines.line_id != lines.max_line_id
    )
    select
        *,
        max(char_id) over (partition by problem_id) as max_char_id,
),

problems(problem_id, max_i, i, item) as (
        select distinct problem_id, max_char_id, 1, '' from problem_metadata
    union all
        select
            problems.problem_id,
            any_value(problems.max_i),
            any_value(problems.i) + 1,
            string_agg(
                problem_metadata.char,
                '' order by problem_metadata.line_id
            ) as item
        from problems
            inner join problem_metadata
                on  problems.problem_id = problem_metadata.problem_id
                and problems.i = problem_metadata.char_id
        where problems.i <= problems.max_i
        group by problems.problem_id
),

solutions as (
    from (
        select
            problem_id,
            item::bigint as item,
            (
                select operator
                from problem_metadata
                where problems.problem_id = problem_metadata.problem_id
                limit 1
            ) as operator,
        from problems
        where item.trim() != ''
    )
    select
        problem_id,
        case any_value(operator)
            when '*' then product(item)
            when '+' then sum(item)
        end as solution
    group by problem_id
)

select sum(solution)::bigint as grand_total
from solutions
;

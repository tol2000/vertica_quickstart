-- some analytics :)
select first_value(name||'  '||min_age||' - '||max_age||' = '||(max_age-min_age))
		over (order by (max_age-min_age) desc) as long,
	  first_value(name||'  '||min_age||' - '||max_age||' = '||(max_age-min_age))
		over (order by (max_age-min_age) asc) as short
  from (
	select
	       name, min(age) as min_age,max(age) as max_age
	  from athlete_external
	  group by name
	  order by max(age)-min(age)
  ) a
  where max_age-min_age>0
  limit 1
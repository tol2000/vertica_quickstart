-- some analytics :)
select long, short, max(glong), min(glong)
       , count(*) as num_of_athlets
  from (
	select
	       first_value(sport||' : '||name||'  '||min(age)||' - '||max(age)||' = '||(max(age)-min(age)))
		    over (partition by sport order by (max(age)-min(age)) desc) as long,
	       first_value(sport||' : '||name||'  '||min(age)||' - '||max(age)||' = '||(max(age)-min(age)))
		    over (partition by sport order by (max(age)-min(age)) asc) as short,
	       max(age) - min(age) as glong
	  from athlete_external
	  group by sport, name
	  having max(age)-min(age)>0
  ) a
  group by long, short
  order by max(glong) desc
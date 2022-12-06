/*Para a segunda questão foi utilizado o recurso de CTE (common table expression)
  para resultados temporários de consulta uma forma mais eficiente, organizada e 
  legivel de estruturar consultas aninhadas ao inves de usar sub selects. No primeiro
  CTE foi utilizado a mesma lógica de consuta da primeira questão sendo para esse caso
  os top 16 fimes. No segundo CTE utilizou-se a consulta do primeiro CTE para relacionar 
  o nome e o id dos atores da tabela actor e film_actor para os 16 filmes mais alugados e 
  por ultimo uma consulta no resultado da segunda consulta temporária para trazer o nome
  completo do ator mais presente nesses filmes.*/
with cte_count as (
select 
	f.film_id,
	count(i.film_id) as quantidade_filme
from 
	rental r
inner join inventory i on r.inventory_id = i.inventory_id
inner join film f on f.film_id = i.film_id
group by 
	f.title,f.film_id 
order by 
	quantidade_filme desc
limit 16
), cte_count_actor as (
select
	c.first_name || ' ' || c.last_name full_name,
	c.actor_id,
	count(c.actor_id) as quantidade_ator
from 
	cte_count cte
inner join film_actor fa on fa.film_id = cte.film_id
inner join actor c on c.actor_id = fa.actor_id
group by 
	full_name,c.actor_id
)
select
	full_name as "nome completo" 
from 
	cte_count_actor 
order by 
	quantidade_ator desc 
limit 1
/*Para a primeira questão foi realizado o relacionamento entre as tabelas de 
  inventory, rental e film para obter as informações necessárias para a primeira
  questão. A coluna inventory_id na tabela de rental é uma Foreign Key para a 
  tabela de inventory assim como a coluna de film_id em inventory é uma Foreign
  Key para a tabela de film sendo assim conseguimos identificar os titulos dos 
  filmes para cada rental_id*/
select 
	f.title as "título do filme", 
	count(i.film_id) as quantidade
from 
	rental r
inner join inventory i on r.inventory_id = i.inventory_id
inner join film f on f.film_id = i.film_id 
group by 
	f.title
order by 
	quantidade
desc limit 2
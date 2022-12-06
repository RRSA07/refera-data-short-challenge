/*Para a terceira questão utilizou-se dois CTEs para realizar as consultas
  temporárias. No primeiro CTE identificamos a data do primeiro filme alugado
  para cada cliente, na segunda consulta colocou-se todas as datas para o 
  primeiro dia do mês no intuito de realizar o agrupamento das informações
  por ultimo utilizamos um select para agrupar e contar quantos clientes novos 
  a empresa teve em cada mês.*/
with cte_min_date as (
select distinct 
	customer_id, 
	min(rental_date) over (partition by customer_id) first_rental
from 
	rental r 
order by 
	customer_id 
), cte_trunc as (
select
	date_trunc('month',first_rental) mês_entrada_cliente
from cte_min_date
)
select
	mês_entrada_cliente::date,
	count(mês_entrada_cliente) 
from 
	cte_trunc 
group by 
	mês_entrada_cliente 
order by 
	mês_entrada_cliente
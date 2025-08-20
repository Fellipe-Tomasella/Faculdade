SELECT distinct ano FROM pesquisa.microdados;

/*1) Crie uma consulta em SQL que retorna todos os anos que as pesquisas eleitorais foram
realizadas.*/

SELECT distinct ano, cargo FROM pesquisa.microdados;

/*2) Crie uma consulta em SQL que retorna todos os anos e cargos que as pesquisas eleitorais foram
realizadas.*/

select distinct instituto from pesquisa.microdados;

/*3) Crie uma consulta em SQL que retorna todos os nomes dos institutos que realizam as pesquisas
eleitorais.*/

SELECT instituto, COUNT(*) AS total_pesquisas FROM pesquisa.microdados GROUP BY instituto ORDER BY total_pesquisas DESC limit 1;

/*4) Crie uma consulta em SQL que retorna o instituto que mais realizou pesquisa eleitoral.*/

SELECT instituto, COUNT(distinct id_pesquisa) AS total_pesquisas FROM pesquisa.microdados GROUP BY instituto ORDER BY total_pesquisas asc;

SELECT instituto, COUNT(DISTINCT id_pesquisa) AS total_pesquisas_distintas FROM pesquisa.microdados GROUP BY instituto 
HAVING 
    COUNT(DISTINCT id_pesquisa) = ( SELECT COUNT(DISTINCT id_pesquisa) FROM pesquisa.microdados GROUP BY instituto ORDER BY COUNT(DISTINCT id_pesquisa) ASC LIMIT 1)
ORDER BY 
    instituto;

/*5) Crie uma consulta em SQL que retorna o instituto que menos realizou pesquisa eleitoral.*/

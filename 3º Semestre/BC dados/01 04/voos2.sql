SELECT cod_ICAO, NOME, MUNICÍPIO FROM voos2024_aovivo.aeroportos;
/* 1 Listar todos os aeroportos cadastrados, exibindo o código, nome e cidade */
SELECT * From empresas_aereas order by nome_empresa;
/* 2 Obter todas as empresas aéreas cadastradas no sistema, ordenando pelo nome em ordem  */
SELECT COUNT(*) AS total_voos FROM voos;
/* 3 Contar quantos voos estão cadastrados no banco de dados. */
SELECT * FROM voos WHERE cod_empresa = (SELECT cod_empresa FROM
empresas_aereas WHERE nome_empresa = 'TAM');
/* 4 Listar voos de uma empresa aérea específica (exemplo: "TAM"). */
SELECT * FROM voos WHERE cod_origem = (SELECT cod_ICAO FROM aeroportos
WHERE MUNICÍPIO = 'Guarulhos');
/* 5 Buscar todos os voos que partem de um aeroporto específico, informando a cidade
(exemplo: "Guarulhos”). */
SELECT * FROM voos WHERE cod_destino = (SELECT cod_ICAO FROM aeroportos
WHERE MUNICÍPIO = 'Cuiabá');
/* 6 Encontrar todos os voos que chegam a um aeroporto específico, informando a cidade
(exemplo: "Cuiabá”). */
SELECT e.nome_empresa AS empresa_aerea, a1.nome AS cod_origem, a2.nome AS
cod_destino
 FROM voos v
 JOIN empresas_aereas e ON v.cod_empresa = e.cod_empresa
 JOIN aeroportos a1 ON v.cod_origem = a1.cod_ICAO
 JOIN aeroportos a2 ON v.cod_destino = a2.cod_ICAO
 group by e.nome_empresa, a1.cod_ICAO, a2.cod_ICAO;
 /* 7 Mostrar detalhes dos voos, incluindo o nome da empresa aérea, aeroporto de
origem e destino. */
SELECT e.nome_empresa AS empresa_aereas, COUNT(v.cod_voos) AS total_voos
FROM empresas_aereas e
JOIN voos v ON e.cod_empresa = v.cod_empresa
GROUP BY e.nome_empresa
ORDER BY total_voos DESC;
/* 8 Exibir o número de voos de cada empresa aérea, ordenando do maior para o menor. */
SELECT a.nome AS aeroporto, COUNT(v.cod_voos) AS total_partidas
FROM aeroportos a
JOIN voos v ON a.cod_ICAO = v.cod_origem
GROUP BY a.nome
ORDER BY total_partidas DESC
LIMIT 1;
/* 9. Exibir o aeroporto que tem mais voos partindo dele. */
SELECT AVG(total_voos) AS media_voos_por_empresa
FROM (SELECT COUNT(v.cod_voos) AS total_voos FROM voos v GROUP BY v.cod_empresa)
AS subquery;
/* 10.Calcular a média de voos por empresa aérea. */
SELECT e.nome_empresa AS empresa_aerea, COUNT(v.cod_voos) AS total_voos
FROM empresas_aereas e
JOIN voos v ON e.cod_empresa = v.cod_empresa
GROUP BY e.nome_empresa
ORDER BY total_voos DESC
LIMIT 1;
/* 11.Descobrir qual empresa aérea tem o maior número de voos registrados. */
SELECT * FROM aeroportos WHERE cod_ICAO NOT IN (SELECT DISTINCT
cod_origem FROM voos);
/* 12.Encontrar os aeroportos que não possuem voos registrados */


/*) Faça uma consulta em Linguagem SQL que seja capaz de retornar todos os voos originados no
estado de Mato Grosso*/

SELECT * FROM aeroportos where UF = "MT";

SELECT v.*, a.MUNICIPIO
FROM voos2024_aovivo.voos v
JOIN aeroportos a on v.cod_origem = a.cod_ICAO
where a.UF = "MT";

/*2) Faça uma consulta em Linguagem SQL que seja capaz de retornar todos os voos originados na
cidade de Sinop.*/

SELECT v.* 
FROM voos2024_aovivo.voos v
JOIN voos2024_aovivo.aeroportos a ON v.cod_origem = a.cod_ICAO
WHERE a.MUNICIPIO = 'Sinop';

/*3) Faça uma consulta em Linguagem SQL que retorna todas as cidades que tem mais de um
aeroporto cadastrado.*/

SELECT MUNICIPIO, COUNT(*) 
AS total_aeroportos
FROM voos2024_aovivo.aeroportos
GROUP BY MUNICIPIO
HAVING COUNT(*) > 1;

/*4) Faça uma consulta em Linguagem SQL que seja capaz de retornar quantos voos cada empresa
aérea fez durante o período cadastrado.*/

SELECT cod_empresa, COUNT(*)
AS total
FROM voos
join empresas_aereas e on v.empresas_aereas = e.cod_empresa
GROUP BY cod_empresa
HAVING COUNT(*) > 0;

/*5) Faça uma consulta em Linguagem SQL que seja capaz de retornar qual voo teve o valor valor de
tarifa registrado.*/

SELECT * 
FROM voos2024_aovivo.voos 
ORDER BY tarifa DESC 
LIMIT 10;



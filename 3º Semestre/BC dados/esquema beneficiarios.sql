/* 1) Crie uma consulta que seja capaz de retornar todos os beneficiários que não informaram o NIS (campo com valor 0). */
SELECT * 
FROM beneficiario 
WHERE nis_beneficiario = 0;

/* 2) Crie uma consulta que seja capaz de retornar todos os beneficiários que informaram o NIS (campo com valor diferente de 0). */
SELECT * 
FROM beneficiario 
WHERE nis_beneficiario <> 0; 
-- Ou: WHERE nis_beneficiario != 0;

/* 3) Crie uma consulta que seja capaz de retornar todos os beneficiários que não tenha responsável informado (campo responsável igual a “não se aplica"). */
SELECT * 
FROM beneficiario 
WHERE nome_responsavel = 'não se aplica';

/* 4) Crie uma consulta que seja capaz de retornar nome do beneficiário e seu respectivo responsável, beneficiários que não tem responsável informado deverão ser omitidos do resultado. */
SELECT nome_beneficiario, nome_responsavel 
FROM beneficiario 
WHERE nome_responsavel <> 'não se aplica'; 
-- Considere adicionar 'AND nome_responsavel IS NOT NULL' se o campo puder ser nulo

/* 5) Crie uma consulta que retorne todos os responsáveis que tem mais de um beneficiário. */
SELECT nome_responsavel, COUNT(id_beneficiario) AS total_beneficiarios 
FROM beneficiario 
WHERE nome_responsavel <> 'não se aplica' -- Exclui os 'não aplicáveis'
GROUP BY nome_responsavel 
HAVING COUNT(id_beneficiario) > 1;

/* 6) Crie uma consulta que seja capaz de retornar todas as pessoas que tenha o cadastro como “BOLSA FAMILIA”. Agrupe o resultado final por nome. (Será necessário utilizar Inner Join). */
SELECT 
    pr.nome_beneficiario -- Seleciona o nome do beneficiário que está na tabela de parcelas.
FROM 
    parcela_rel pr -- Define a tabela 'parcela_rel' como a principal fonte de dados e a apelida de 'pr'.
INNER JOIN 
    enquadramento e ON pr.id_enquadramento = e.idEnquadramento -- Junta 'parcela_rel' com 'enquadramento' (apelidada 'e') onde os IDs de enquadramento correspondem.
WHERE 
    e.tipo_enquadramento = 'BOLSA FAMILIA' -- Filtra os resultados para incluir apenas aqueles cujo tipo de enquadramento é 'BOLSA FAMILIA'.
GROUP BY 
    pr.nome_beneficiario -- Agrupa as linhas pelo nome do beneficiário, para que cada nome apareça apenas uma vez no resultado.
ORDER BY 
    pr.nome_beneficiario; -- Ordena os nomes dos beneficiários em ordem alfabética (opcional, mas melhora a leitura).

/* 7) Crie uma consulta que seja capaz de retornar a soma total de quanto cada beneficiário recebeu. */
SELECT 
    nome_beneficiario, -- Seleciona o nome do beneficiário.
    SUM(valor) AS soma_total_auxilio -- Calcula a soma de todos os valores da coluna 'valor' para cada grupo e nomeia essa soma como 'soma_total_auxilio'.
FROM 
    parcela_rel -- Indica que os dados virão da tabela 'parcela_rel'.
GROUP BY 
    nome_beneficiario -- Agrupa as linhas pelo 'nome_beneficiario', para que a função SUM() calcule o total para cada nome diferente.
ORDER BY 
    soma_total_auxilio DESC; -- Ordena os resultados pela soma total recebida, do maior para o menor (opcional).

/* 8) Crie uma consulta que seja capaz de retornar quem foi o beneficiário que recebeu a maior soma do auxílio. */
SELECT 
    nome_beneficiario, -- Seleciona o nome do beneficiário.
    SUM(valor) AS soma_total_auxilio -- Calcula a soma dos valores das parcelas para cada beneficiário e nomeia o resultado.
FROM 
    parcela_rel -- Especifica a tabela 'parcela_rel' como fonte dos dados.
GROUP BY 
    nome_beneficiario -- Agrupa as linhas por nome para que a soma seja calculada para cada pessoa.
ORDER BY 
    soma_total_auxilio DESC -- Ordena os beneficiários pela soma total recebida, colocando o maior valor no topo.
LIMIT 1; -- Restringe o resultado a apenas a primeira linha após a ordenação (ou seja, o beneficiário com a maior soma).

/* 9) Crie uma consulta que seja capaz de retornar quem foram os 10 beneficiários que receberam as maiores somas do auxílio. */
SELECT 
    nome_beneficiario, -- Seleciona o nome do beneficiário.
    SUM(valor) AS soma_total_auxilio -- Calcula a soma dos valores das parcelas para cada beneficiário.
FROM 
    parcela_rel -- Indica a tabela 'parcela_rel'.
GROUP BY 
    nome_beneficiario -- Agrupa as linhas por nome para calcular a soma individual.
ORDER BY 
    soma_total_auxilio DESC -- Ordena os resultados pela soma total, da maior para a menor.
LIMIT 10; -- Restringe o resultado às 10 primeiras linhas após a ordenação (os 10 maiores).

/* 10) A beneficiária MARIA DE FATIMA DA SILVA recebeu o maior valor de auxílio, tal valor é incompatível com as regras do auxilio, identifique onde está a inconsistência. Dica: será que a MARIA tem homônimas? Como saber disso? Beneficiário x parcela_rel, inner join */
-- Consulta 1: Detalhes das parcelas individuais para 'MARIA DE FATIMA DA SILVA', incluindo CPF para diferenciar homônimas.
SELECT 
    b.nome_beneficiario, -- Seleciona o nome da tabela 'beneficiario'.
    b.cpf_beneficiario, -- Seleciona o CPF da tabela 'beneficiario' para identificar a pessoa única.
    pr.id_parcela,       -- Seleciona o ID único de cada parcela recebida.
    pr.num_parcela,      -- Seleciona o número da parcela (ex: '1', '2').
    pr.valor             -- Seleciona o valor individual da parcela (onde pode estar a inconsistência).
FROM 
    parcela_rel pr -- Começa com a tabela de parcelas ('pr').
INNER JOIN 
    beneficiario b ON pr.nome_beneficiario = b.nome_beneficiario -- Junta com a tabela 'beneficiario' ('b') usando a coluna 'nome_beneficiario' como chave (atenção: pode ser impreciso com nomes levemente diferentes).
WHERE 
    pr.nome_beneficiario = 'MARIA DE FATIMA DA SILVA' -- Filtra para mostrar apenas as parcelas associadas a este nome.
ORDER BY 
    b.cpf_beneficiario, pr.valor DESC; -- Ordena primeiro pelo CPF (agrupando as parcelas de cada homônima) e depois pelo valor da parcela (maior primeiro) para destacar valores altos.

-- Consulta 2: Soma total e maior parcela por homônima 'MARIA DE FATIMA DA SILVA'.
SELECT 
    b.nome_beneficiario, -- Seleciona o nome.
    b.cpf_beneficiario, -- Seleciona o CPF para identificar a homônima.
    COUNT(pr.id_parcela) AS numero_parcelas, -- Conta quantas parcelas cada homônima recebeu.
    SUM(pr.valor) AS soma_total_recebida, -- Calcula a soma total que cada homônima recebeu.
    MAX(pr.valor) AS maior_valor_parcela -- Mostra o valor da maior parcela individual recebida por cada homônima.
FROM 
    parcela_rel pr -- Começa com a tabela de parcelas.
INNER JOIN 
    beneficiario b ON pr.nome_beneficiario = b.nome_beneficiario -- Junta com beneficiários pelo nome.
WHERE 
    pr.nome_beneficiario = 'MARIA DE FATIMA DA SILVA' -- Filtra pelo nome específico.
GROUP BY 
    b.nome_beneficiario, b.cpf_beneficiario -- Agrupa por nome E CPF, tratando cada homônima como um grupo separado.
ORDER BY 
    soma_total_recebida DESC; -- Ordena as homônimas pela soma total recebida, da maior para a menor.

/* 11) Crie uma consulta que seja capaz de agrupar quem recebeu apenas a 1ª parcela, apenas a 2ª parcela, apenas a 3ª parcela ... */
-- Exemplo: Quem recebeu APENAS uma parcela e esta foi a de número '1'.
SELECT 
    nome_beneficiario -- Seleciona o nome do beneficiário.
FROM 
    parcela_rel -- Indica a tabela 'parcela_rel'.
GROUP BY 
    nome_beneficiario -- Agrupa todas as parcelas por nome de beneficiário.
HAVING 
    COUNT(DISTINCT num_parcela) = 1 -- Filtra os grupos: mantém apenas aqueles que têm exatamente UM número de parcela distinto.
    AND MAX(num_parcela) = '1'; -- E também exige que o único número de parcela (que será o máximo e o mínimo) seja '1'.

-- Para encontrar quem recebeu APENAS a 2ª parcela, mude a última linha para: AND MAX(num_parcela) = '2';
-- Para encontrar quem recebeu APENAS a 3ª parcela, mude a última linha para: AND MAX(num_parcela) = '3';
-- E assim por diante para outras parcelas.

/* 12) Crie uma consulta que seja capaz de apresentar todos as pessoas que são homônimas, lembrem-se nomes iguais mas cpfs diferentes. */
-- Consulta 1: Encontrar os nomes que estão associados a mais de um CPF diferente.
SELECT 
    nome_beneficiario -- Seleciona o nome do beneficiário.
FROM 
    beneficiario -- Indica a tabela 'beneficiario'.
WHERE 
    cpf_beneficiario IS NOT NULL -- Considera apenas registros onde o CPF não é nulo (para evitar contar nulos como CPFs diferentes).
GROUP BY 
    nome_beneficiario -- Agrupa as linhas por nome.
HAVING 
    COUNT(DISTINCT cpf_beneficiario) > 1; -- Filtra os grupos: mantém apenas os nomes que têm mais de um CPF distinto associado a eles.

-- Consulta 2: Listar os detalhes (nome, CPF, id) das pessoas identificadas como homônimas na consulta anterior.
SELECT 
    nome_beneficiario, -- Seleciona o nome.
    cpf_beneficiario, -- Seleciona o CPF.
    id_beneficiario -- Seleciona o ID único do beneficiário (chave primária).
FROM 
    beneficiario -- Indica a tabela 'beneficiario'.
WHERE 
    nome_beneficiario IN ( -- Filtra a tabela 'beneficiario', mantendo apenas as linhas cujo 'nome_beneficiario'...
        -- Início da Subconsulta:
        SELECT 
            nome_beneficiario -- ...esteja presente na lista de nomes retornada por esta subconsulta.
        FROM 
            beneficiario -- A subconsulta busca na tabela 'beneficiario'...
        WHERE 
            cpf_beneficiario IS NOT NULL -- ...considerando apenas CPFs não nulos...
        GROUP BY 
            nome_beneficiario -- ...agrupa por nome...
        HAVING 
            COUNT(DISTINCT cpf_beneficiario) > 1 -- ...e retorna apenas os nomes com múltiplos CPFs distintos.
        -- Fim da Subconsulta
    )
ORDER BY 
    nome_beneficiario, cpf_beneficiario; -- Ordena os resultados primeiro por nome, e depois por CPF, para facilitar a visualização dos homônimos juntos.

/* 13) Crie uma consulta que seja capaz de apresentar todos os beneficiários do estado de Mato Grosso. */
SELECT 
    b.* -- Seleciona TODAS as colunas (*) da tabela 'beneficiario' (apelidada como 'b').
FROM 
    beneficiario b -- Define a tabela 'beneficiario' como fonte principal e a apelida de 'b'.
INNER JOIN 
    municipio m ON b.id_municipio_ibge = m.idmunicipioIBGE -- Junta 'beneficiario' com 'municipio' (apelidada 'm') usando a coluna de ID do município como chave de ligação.
WHERE 
    m.estado = 'MT'; -- Filtra os resultados para incluir apenas as linhas onde a coluna 'estado' na tabela 'municipio' é igual a 'MT'.

/* 14) Crie uma consulta que seja capaz de apresentar todos os beneficiários da cidade de Sinop. */
SELECT 
    b.* -- Seleciona TODAS as colunas (*) da tabela 'beneficiario' (apelidada 'b').
FROM 
    beneficiario b -- Define a tabela 'beneficiario' como fonte e a apelida de 'b'.
INNER JOIN 
    municipio m ON b.id_municipio_ibge = m.idmunicipioIBGE -- Junta 'beneficiario' com 'municipio' ('m') pela chave do ID do município.
WHERE 
    m.nome_municipio = 'Sinop'; -- Filtra os resultados para incluir apenas aqueles onde a coluna 'nome_municipio' na tabela 'municipio' é 'Sinop'.

/* 15) Crie uma consulta que seja capaz de apresentar quanto de repasse foi realizado para cada estado. */
SELECT 
    m.estado, -- Seleciona a sigla do estado da tabela 'municipio'.
    SUM(pr.valor) AS total_repassado_estado -- Calcula a soma dos valores das parcelas para cada estado e nomeia o resultado.
FROM 
    parcela_rel pr -- Começa com a tabela de parcelas ('pr') que contém os valores.
INNER JOIN 
    beneficiario b ON pr.nome_beneficiario = b.nome_beneficiario -- Junta parcelas com beneficiários pelo nome, para poder ligar ao município.
INNER JOIN 
    municipio m ON b.id_municipio_ibge = m.idmunicipioIBGE -- Junta beneficiários com municípios pelo ID do município, para obter o estado.
GROUP BY 
    m.estado -- Agrupa os resultados por estado, para que SUM() calcule o total para cada estado separadamente.
ORDER BY 
    total_repassado_estado DESC; -- Ordena os estados pelo total repassado, do maior para o menor (opcional).

/* 16) Crie uma consulta que seja capaz de apresentar quanto de repasse foi realizado para cada cidade. */
SELECT 
    m.nome_municipio, -- Seleciona o nome do município.
    m.estado, -- Seleciona também o estado, para diferenciar cidades com o mesmo nome em estados diferentes.
    SUM(pr.valor) AS total_repassado_cidade -- Calcula a soma dos valores das parcelas para cada cidade e nomeia o resultado.
FROM 
    parcela_rel pr -- Começa com a tabela de parcelas ('pr').
INNER JOIN 
    beneficiario b ON pr.nome_beneficiario = b.nome_beneficiario -- Junta com beneficiários pelo nome.
INNER JOIN 
    municipio m ON b.id_municipio_ibge = m.idmunicipioIBGE -- Junta com municípios pelo ID, para obter o nome da cidade e estado.
GROUP BY 
    m.idmunicipioIBGE, m.nome_municipio, m.estado -- Agrupa pelo ID do município (chave primária, mais seguro), nome da cidade E estado, para garantir que cada cidade única seja um grupo.
ORDER BY 
    total_repassado_cidade DESC; -- Ordena as cidades pelo total repassado, do maior para o menor (opcional).
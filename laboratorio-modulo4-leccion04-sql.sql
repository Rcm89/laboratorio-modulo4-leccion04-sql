--EJERCICIO 1: QUERIES SIMPLES

--1.1  Calcula el promedio más bajo y más alto de temperatura
-- Promedio más bajo
SELECT AVG(temperatura) AS temperatura_promedio_minima
FROM clima
GROUP BY municipio_id
ORDER BY AVG(temperatura) ASC
LIMIT 1;
-- Promedio más alto
SELECT AVG(temperatura) AS temperatura_promedio_maxima
FROM clima
GROUP BY municipio_id
ORDER BY AVG(temperatura) DESC
LIMIT 1;

--1.2. Obtén los municipios en los cuales coincidan las medias de la sensación térmica y de la temperatura. 
SELECT municipio_id, temperatura AS temperatura_media, sensacion AS sensacion_termica_media
FROM clima
GROUP BY municipio_id, temperatura, sensacion
HAVING AVG(temperatura) = AVG(sensacion);

--1.3. Obtén el local más cercano de cada municipio
SELECT id_municipio, nombre, MIN(distancia) AS distancia_mas_cercana
FROM lugares
GROUP BY id_municipio, nombre
ORDER BY id_municipio;

--1.4. Localiza los municipios que posean algún local a una distancia mayor de 2000 y que posean al menos
-- 25 locales
SELECT id_municipio
FROM lugares
GROUP BY id_municipio
HAVING MAX(distancia) > 2000 AND COUNT(id_local) >= 25;

--1.5. Teniendo en cuenta que el viento se considera leve con una velocidad media de entre 6 y 20 km/h,
-- moderado con una media de entre 21 y 40 km/h, fuerte con media de entre 41 y 70 km/h y muy fuerte entre
-- 71 y 120 km/h. Calcula cuántas rachas de cada tipo tenemos en cada uno de los días. Este ejercicio debes
-- solucionarlo con la sentencia CASE de SQL

SELECT fecha,
    SUM(CASE 
        WHEN racha_max BETWEEN 6 AND 20 THEN 1 
        ELSE 0 
    END) AS viento_leve,
    SUM(CASE 
        WHEN racha_max BETWEEN 21 AND 40 THEN 1 
        ELSE 0 
    END) AS viento_moderado,
    SUM(CASE 
        WHEN racha_max BETWEEN 41 AND 70 THEN 1 
        ELSE 0 
    END) AS viento_fuerte,
    SUM(CASE 
        WHEN racha_max BETWEEN 71 AND 120 THEN 1 
        ELSE 0 
    END) AS viento_muy_fuerte
FROM clima
GROUP BY fecha
ORDER BY fecha;

--Ejercicio 2. Vistas

--Crea una vista que muestre la información de los locales que tengan incluido el código postal en su dirección

CREATE VIEW locales_con_codigo_postal AS
SELECT *
FROM lugares
WHERE direccion SIMILAR TO '%[0-9]{5}%';

--2.2. Crea una vista con los locales que tienen más de una categoría asociada

CREATE VIEW locales_con_multiples_categorias AS
SELECT id_local, id_municipio, COUNT(categoria) AS numero_categorias
FROM lugares
GROUP BY id_local, id_municipio
HAVING COUNT(categoria) > 1;

-- esta vista esta vacía porque los locales no tienen mas de una categoria asociada. Como no he estado en
-- clase y no se si es una errata del enunciado. Lo saco para los municipios que nos dará una vista no vacía.

CREATE VIEW municipios_con_multiples_categorias AS
SELECT id_municipio, COUNT(DISTINCT categoria) AS numero_categorias
FROM lugares
GROUP BY id_municipio
HAVING COUNT(DISTINCT categoria) > 1;

--2.3. Crea una vista que muestre el municipio con la temperatura más alta de cada día

CREATE VIEW municipio_temperatura_maxima_dia AS
SELECT fecha, municipio_id, temperatura
FROM clima c1
WHERE temperatura = (
    SELECT MAX(temperatura)
    FROM clima c2
    WHERE c1.fecha = c2.fecha
);

--2.4. Crea una vista con los municipios en los que haya una probabilidad de precipitación mayor del 100% durante mínimo 7 horas

CREATE VIEW municipios_lluvia_segura AS
SELECT municipio_id, fecha
FROM clima
WHERE precipitacion > 100
GROUP BY municipio_id, fecha
HAVING COUNT(*) >= 7;

--2.5. Obtén una lista con los parques de los municipios que tengan algún castillo.

CREATE VIEW parques_de_municipios_con_castillos AS
SELECT DISTINCT l1.nombre, l1.id_municipio, l1.categoria, l1.direccion
FROM lugares l1
JOIN lugares l2
    ON l1.id_municipio = l2.id_municipio
WHERE l1.categoria = 'Park'
AND l2.categoria = 'Castle'

--Ejercicio 3. Tablas Temporales

--3.1. Crea una tabla temporal que muestre cuántos días han pasado desde que se obtuvo la información de la 
--tabla AEMET

CREATE TEMPORARY TABLE dias_desde_informacion_aemet AS
SELECT municipio_id, fecha, CURRENT_DATE - fecha AS dias_transcurridos
FROM clima;

SELECT * FROM dias_desde_informacion_aemet;

--3.2 Crea una tabla temporal que muestre los locales que tienen más de una categoría asociada e indica
-- el conteo de las mismas

CREATE TEMPORARY TABLE conteo_locales_multiples_categorias AS
SELECT id_local, id_municipio, COUNT(categoria) AS numero_categorias
FROM lugares
GROUP BY id_local, id_municipio
HAVING COUNT(categoria) > 1;

--3.3. Crea una tabla temporal que muestre los tipos de cielo para los cuales la probabilidad de precipitación mínima de los promedios de cada día es 5

CREATE TEMPORARY TABLE tipos_cielo_con_precipitacion_minima AS
SELECT cielo, fecha
FROM clima
GROUP BY cielo, fecha
HAVING AVG(precipitacion) = 5;

-- 3.4. Crea una tabla temporal que muestre el tipo de cielo más y menos repetido por municipio

-- Este no he sabido hacerlo
CREATE TEMPORARY TABLE cielo_repetido_frecuencia as

--Ejercicio 4. SUBQUERIES











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





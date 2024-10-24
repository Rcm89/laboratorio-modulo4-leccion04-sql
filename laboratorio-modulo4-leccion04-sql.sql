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




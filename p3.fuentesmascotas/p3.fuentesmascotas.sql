SELECT *
FROM `p3.fuentesmascotas`;

-- Estandarizar fechas

SELECT FECHA_INSTALACION, DATE (FECHA_INSTALACION)
FROM `p3.fuentesmascotas`
WHERE FECHA_INSTALACION <> '' AND FECHA_INSTALACION IS NOT NULL;

ALTER TABLE `p3.fuentesmascotas`
ADD fecha_instalacion_converted DATE;

UPDATE `p3.fuentesmascotas`
SET fecha_instalacion_converted = DATE (FECHA_INSTALACION)
WHERE FECHA_INSTALACION <> '' AND FECHA_INSTALACION IS NOT NULL;

-- Separar dirección

SELECT
    DIRECCION,
    SUBSTRING_INDEX(DIRECCION, ' ', 1) AS direccion_tipo_de_via,
    TRIM(SUBSTRING(SUBSTRING_INDEX(DIRECCION, ',', 1), LENGTH(SUBSTRING_INDEX(DIRECCION, ' ', 1)) + 2)) AS direccion_nombre,
    TRIM(SUBSTRING_INDEX(DIRECCION, ',', -1)) AS direccion_numero
FROM `p3.fuentesmascotas`;

ALTER TABLE `p3.fuentesmascotas`
ADD direccion_tipo_de_via VARCHAR(255);

ALTER TABLE `p3.fuentesmascotas`
ADD direccion_nombre VARCHAR(255);

ALTER TABLE `p3.fuentesmascotas`
ADD direccion_numero VARCHAR(255);

UPDATE `p3.fuentesmascotas`
SET direccion_tipo_de_via = SUBSTRING_INDEX(DIRECCION, ' ', 1);

UPDATE `p3.fuentesmascotas`
SET direccion_nombre = TRIM(SUBSTRING(SUBSTRING_INDEX(DIRECCION, ',', 1), LENGTH(SUBSTRING_INDEX(DIRECCION, ' ', 1)) + 2));

UPDATE `p3.fuentesmascotas`
SET direccion_numero = TRIM(SUBSTRING_INDEX(DIRECCION, ',', -1))

-- Categorizar fuentes aptas para el concumo humano
	
SELECT USO,
CASE WHEN 
	USO LIKE '%personas%' THEN 'Sí'
    ELSE 'No' END
FROM `p3.fuentesmascotas`;

ALTER TABLE `p3.fuentesmascotas`
ADD apto_consumo_humano CHAR(2);

UPDATE `p3.fuentesmascotas`
SET apto_consumo_humano = 	
	CASE WHEN 
		USO LIKE '%personas%' THEN 'Sí'
		ELSE 'No' END

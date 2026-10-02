-- =====================================================================
-- OCEANLINK - CONSULTAS SQL SELECT
-- =====================================================================

USE `MiBaseDeDatos`;


-- =====================================================================
-- 1. SELECT DISTINCT Y ORDER BY
-- =====================================================================

-- 1.1
SELECT DISTINCT 
    pais AS 'País'
FROM LANDING_STATION 
ORDER BY pais ASC;

-- 1.2
SELECT DISTINCT 
    estado AS 'Estado'
FROM SEGMENTO 
ORDER BY estado ASC;


-- =====================================================================
-- 2. WHERE
-- =====================================================================

-- 2.1
SELECT 
    dni_usuario AS 'DNI',
    CONCAT(nombre, ' ', apellido_1, ' ', apellido_2) AS 'Usuario',
    correo AS 'Correo'
FROM USUARIO 
WHERE estado = 'Activo' 
  AND ROL_id_rol = 3;

-- 2.2
SELECT 
    id_solicitud AS 'ID Solicitud',
    capacidad_requerida AS 'Capacidad Requerida',
    estado AS 'Estado',
    fecha_solicitud AS 'Fecha de Solicitud'
FROM SOLICITUD_CAPACIDAD 
WHERE capacidad_requerida BETWEEN 500.00 AND 1500.00 
ORDER BY capacidad_requerida DESC;

-- 2.3
SELECT 
    codigo_incidencia AS 'Código',
    titulo AS 'Incidencia',
    severidad AS 'Severidad',
    estado AS 'Estado',
    fecha_deteccion AS 'Fecha de Detección'
FROM INCIDENCIA 
WHERE severidad IN ('Alta', 'Crítica')
ORDER BY fecha_deteccion DESC;

-- 2.4
SELECT 
    id_cliente AS 'ID Cliente',
    razon_social AS 'Razón Social',
    ruc AS 'RUC',
    correo AS 'Correo'
FROM CLIENTE 
WHERE razon_social LIKE '%S.A.C.' 
   OR correo LIKE '%.pe';

-- 2.5
SELECT 
    id_finalizacion AS 'ID Finalización',
    resultado AS 'Resultado',
    resumen_final AS 'Resumen Final',
    observacion AS 'Observación'
FROM FINALIZACION_MANTENIMIENTO 
WHERE observacion IS NOT NULL;


-- =====================================================================
-- 3. GROUP BY, AGREGACIÓN, HAVING Y LIMIT
-- =====================================================================

-- 3.1
SELECT 
    pais AS 'País', 
    COUNT(id_landing) AS 'Total Estaciones'
FROM LANDING_STATION 
GROUP BY pais 
ORDER BY `Total Estaciones` DESC;

-- 3.2
SELECT 
    c.razon_social AS 'Cliente',
    COUNT(s.id_servicio) AS 'Cant. Servicios',
    SUM(s.capacidad_contratada) AS 'Capacidad Total Contratada',
    TRUNCATE(AVG(s.capacidad_contratada), 2) AS 'Capacidad Promedio',
    MIN(s.capacidad_contratada) AS 'Mínima Contratada',
    MAX(s.capacidad_contratada) AS 'Máxima Contratada'
FROM SERVICIO s
JOIN CLIENTE c 
    ON s.CLIENTE_id_cliente = c.id_cliente
WHERE s.estado = 'Activo'
GROUP BY c.razon_social
HAVING SUM(s.capacidad_contratada) > 1500.00
ORDER BY `Capacidad Total Contratada` DESC;

-- 3.3
SELECT 
    codigo_segmento AS 'Código Segmento', 
    capacidad_total AS 'Capacidad Total', 
    capacidad_utilizada AS 'Capacidad Utilizada', 
    TRUNCATE(
        (capacidad_utilizada / capacidad_total) * 100, 
        2
    ) AS 'Porcentaje Uso (%)'
FROM SEGMENTO
ORDER BY capacidad_utilizada DESC
LIMIT 3;


-- =====================================================================
-- 4. INNER JOIN
-- =====================================================================

-- 4.1
SELECT 
    s.id_servicio AS 'ID Servicio',
    c.razon_social AS 'Cliente',
    c.ruc AS 'RUC',
    r.codigo AS 'Código Ruta',
    s.capacidad_contratada AS 'Capacidad (Gbps)',
    s.fecha_activacion AS 'Fecha Activación'
FROM SERVICIO s
INNER JOIN CLIENTE c 
    ON s.CLIENTE_id_cliente = c.id_cliente
INNER JOIN RUTA r 
    ON s.RUTA_id_ruta = r.id_ruta
WHERE s.estado = 'Activo'
ORDER BY s.capacidad_contratada DESC;

-- 4.2
SELECT 
    i.codigo_incidencia AS 'Código',
    i.titulo AS 'Incidencia',
    i.severidad AS 'Severidad',
    ls.nombre AS 'Estación Afectada',
    ls.ciudad AS 'Ciudad',
    i.SEGMENTO_codigo_segmento AS 'Segmento Fibra'
FROM INCIDENCIA i
INNER JOIN LANDING_STATION ls 
    ON i.LANDING_STATION_id_landing = ls.id_landing
ORDER BY i.fecha_deteccion DESC;


-- =====================================================================
-- 5. LEFT JOIN
-- =====================================================================

-- 5.1
SELECT 
    ls.id_landing AS 'ID Estación',
    ls.nombre AS 'Nombre Estación',
    ls.pais AS 'País',
    i.codigo_incidencia AS 'Código Incidencia',
    i.titulo AS 'Título Incidencia',
    i.estado AS 'Estado Incidencia'
FROM LANDING_STATION ls
LEFT JOIN INCIDENCIA i 
    ON ls.id_landing = i.LANDING_STATION_id_landing
ORDER BY ls.id_landing;

-- 5.2
SELECT 
    m.codigo_mantenimiento AS 'Mantenimiento',
    m.tipo AS 'Tipo',
    m.estado AS 'Estado Mnt.',
    am.titulo AS 'Actividad',
    fm.resultado AS 'Resultado Final'
FROM MANTENIMIENTO m
LEFT JOIN ACTIVIDAD_MANTENIMIENTO am 
    ON m.ACTIVIDAD_MANTENIMIENTO_id_actividad = am.id_actividad
LEFT JOIN FINALIZACION_MANTENIMIENTO fm 
    ON m.FINALIZACION_MANTENIMIENTO_id_finalizacion = fm.id_finalizacion
ORDER BY m.codigo_mantenimiento;


-- =====================================================================
-- 6. RIGHT JOIN
-- =====================================================================

-- 6.1
SELECT 
    r.codigo AS 'Código Ruta',
    r.estado AS 'Estado Ruta',
    COUNT(rhs.SEGMENTO_codigo_segmento) AS 'Cantidad Segmentos'
FROM RUTA_has_SEGMENTO rhs
RIGHT JOIN RUTA r 
    ON rhs.RUTA_id_ruta = r.id_ruta
GROUP BY r.id_ruta, r.codigo, r.estado
ORDER BY r.id_ruta;


-- =====================================================================
-- 7. JOINS MÚLTIPLES
-- =====================================================================

-- 7.1
SELECT 
    sc.id_solicitud AS 'ID Solicitud',
    CONCAT(u.nombre, ' ', u.apellido_1) AS 'Usuario Solicitante',
    rol.nombre AS 'Rol Usuario',
    r.codigo AS 'Ruta Propuesta',
    sc.capacidad_requerida AS 'Capacidad Requerida',
    sc.estado AS 'Estado Actual',
    hs.estado AS 'Estado Historial',
    hs.fecha AS 'Fecha Cambio',
    sc.observaciones AS 'Observaciones'
FROM SOLICITUD_CAPACIDAD sc
INNER JOIN USUARIO u 
    ON sc.USUARIO_id_usuario = u.dni_usuario
INNER JOIN ROL rol 
    ON u.ROL_id_rol = rol.id_rol
INNER JOIN RUTA r 
    ON sc.id_ruta_propuesta = r.id_ruta
LEFT JOIN HIST_SOLICITUD hs 
    ON sc.HIST_SOLICITUD_id_historial = hs.id_historial
ORDER BY sc.id_solicitud ASC;

-- 7.2
SELECT 
    seg.codigo_segmento AS 'Código Segmento',
    ls_origen.nombre AS 'Estación Origen',
    ls_origen.pais AS 'País Origen',
    ls_destino.nombre AS 'Estación Destino',
    ls_destino.pais AS 'País Destino',
    seg.capacidad_total AS 'Cap. Total',
    seg.capacidad_utilizada AS 'Cap. Utilizada',
    m.codigo_mantenimiento AS 'Mantenimiento',
    m.estado AS 'Estado Mantenimiento'
FROM SEGMENTO seg
INNER JOIN LANDING_STATION ls_origen 
    ON seg.LANDING_STATION_id_origen = ls_origen.id_landing
INNER JOIN LANDING_STATION ls_destino 
    ON seg.LANDING_STATION_id_destino = ls_destino.id_landing
LEFT JOIN MANTENIMIENTO m 
    ON seg.MANTENIMIENTO_id_mantenimiento = m.codigo_mantenimiento
ORDER BY seg.codigo_segmento;

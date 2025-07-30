USE hotel_reservas;

-- Parte 1: Limpieza de datos --

-- 1 --
-- Mostrar datos nulos de la tabla clientes --
select * from clientes where rut is null or correo is null;

-- Mostrar datos nulos de la tabla personal --
select * from personal where nombre_completo is null or correo is null;

-- Mostrar datos nulos de la tabla reservas --
select * from reservas where fecha_ingreso is null or fecha_salida is null or estado is null;

-- 2 --

-- Eliminar clientes con rut NULL
delete from clientes where rut is null;

-- Eliminar personal con nombre_completo NULL
delete from personal where nombre_completo is null;

-- Eliminar reservas con estado NULL
delete from reservas where estado is null;

-- 3 --

-- Actualizar correo de un cliente que tenga NULL
update clientes  set correo = 'andres.lopez@email.com' where id_cliente = 3 and correo is null;

-- Completar fecha_ingreso de una reserva que tenga NULL
update reservas set fecha_ingreso = '2025-08-15' where id_reserva = 2 and fecha_ingreso is null;

-- Parte 2: Borrado Lógico y Filtrado Activo --

-- 4 --

-- Marcar como deleted una habitación y un cliente
update habitaciones set deleted = 1 where id_habitacion = 7;

update clientes set deleted = 1 where id_cliente = 8;

-- Mostrar solo habitaciones activas
select * from habitaciones where deleted = 0;

-- Mostrar solo clientes activos
select * from clientes where deleted = 0;

-- 5 --

-- Habitaciones inactivas
select * from habitaciones where deleted = 1;

-- Clientes inactivos
select * from clientes where deleted = 1;

-- Parte 3: Consultas con INNER JOIN --

-- 6 --

-- Clientes activos con su tipo
select c.nombre_completo, c.correo, t.nombre_tipo 
from clientes c 
inner join tipo_clientes t on c.id_tipo_cliente = t.id_tipo_cliente 
where c.deleted = 0;

-- 7 --

-- Clientes, habitaciones y reservas activas
select c.nombre_completo, h.numero_habitacion, r.estado 
from clientes c
inner join reservas r on c.id_cliente = r.id_cliente
inner join habitaciones h on r.id_habitacion = h.id_habitacion
where c.deleted = 0 and r.deleted = 0;

-- 8 --

-- Clientes, personal, habitaciones y reservas activas
select c.nombre_completo, p.nombre_completo, h.numero_habitacion, r.estado
from clientes c
inner join reservas r on c.id_cliente = r.id_cliente
inner join personal p on r.id_personal = p.id_personal
inner join habitaciones h on r.id_habitacion = h.id_habitacion
where c.deleted = 0 and r.deleted = 0 and p.deleted = 0 and h.deleted = 0;

-- Parte 4: Consultas con Filtros Avanzados --

-- 9 --

-- Reservas con estado 'confirmada'
select * from reservas where estado = 'confirmada' and deleted = 0;

-- Clientes activos con correo de más de 15 caracteres
select * from clientes WHERE LENGTH(correo) > 15 and deleted = 0;

-- 10 --

-- Reservas después del 2025-08-10 en estado 'pendiente'
select * from reservas where fecha_ingreso > '2025-08-10' and estado = 'pendiente' and deleted = 0;

-- Habitaciones activas disponibles
select * from habitaciones where estado = 'disponible' and deleted = 0;
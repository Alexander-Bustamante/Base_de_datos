
USE `agencia_viajes` ;

INSERT INTO `tipo_usuario` (`nombre_tipo_usuario`, `descripcion`, `created`, `modified`, `usuario_id`, `delete`)
VALUES 
('Administrador', 'Usuario con permisos de administración', NOW(), NOW(), 1, 0),
('Cliente', 'Usuario que realiza reservas y compras', NOW(), NOW(), 1, 0),
('Agente', 'Usuario que gestiona viajes y reservas', NOW(), NOW(), 1, 0),
('Invitado', 'Usuario sin registro completo', NOW(), NOW(), 1, 0),
('Supervisor', 'Usuario que supervisa operaciones', NOW(), NOW(), 1, 0);

INSERT INTO `personas` (`RUT`, `nombre`, `apellido`, `fecha_nac`, `created`, `modified`, `usuario_id`, `delete`)
VALUES 
(12345678, 'Juan', 'Pérez', '1990-05-15', NOW(), NOW(), 1, 0),
(23456789, 'María', 'Gómez', '1985-08-22', NOW(), NOW(), 1, 0),
(34567890, 'Carlos', 'López', '1978-12-10', NOW(), NOW(), 1, 0),
(45678901, 'Ana', 'Martínez', '1995-03-25', NOW(), NOW(), 1, 0),
(56789012, 'Luis', 'Rodríguez', '1982-07-30', NOW(), NOW(), 1, 0);

INSERT INTO `usuarios` (`username`, `password`, `email`, `created`, `modified`, `usuario_id`, `delete`, `RUT`, `id_tipo_usuario`)
VALUES 
('juanperez', 'pass123', 'juan.perez@example.com', NOW(), NOW(), 1, 0, 12345678, 1),
('mariagomez', 'pass456', 'maria.gomez@example.com', NOW(), NOW(), 1, 0, 23456789, 2),
('carloslopez', 'pass789', 'carlos.lopez@example.com', NOW(), NOW(), 1, 0, 34567890, 2),
('anamartinez', 'pass012', 'ana.martinez@example.com', NOW(), NOW(), 1, 0, 45678901, 2),
('luisrodriguez', 'pass345', 'luis.rodriguez@example.com', NOW(), NOW(), 1, 0, 56789012, 2);

INSERT INTO `tipo_viaje` (`nombre_tipo_viaje`, `descripcion`, `created`, `modified`, `usuario_id`, `delete`)
VALUES 
('Económico', 'Viaje con tarifa básica', NOW(), NOW(), 1, 0),
('Negocios', 'Viaje con comodidades adicionales', NOW(), NOW(), 1, 0),
('Primera Clase', 'Viaje con lujo y máximo confort', NOW(), NOW(), 1, 0),
('Familiar', 'Viaje con descuentos para familias', NOW(), NOW(), 1, 0),
('Promocional', 'Viaje con tarifas especiales', NOW(), NOW(), 1, 0);

INSERT INTO `registro_viajes` (`id_registro_viajes`, `agencia`, `llegada`, `salida`, `created`, `modified`, `usuario_id`, `delete`, `id_tipo_viaje`)
VALUES 
(1, 'Agencia A', '2023-10-15 14:00:00', '2023-10-15 10:00:00', NOW(), NOW(), 1, 0, 1),
(2, 'Agencia B', '2023-10-16 15:00:00', '2023-10-16 11:00:00', NOW(), NOW(), 1, 0, 2),
(3, 'Agencia C', '2023-10-17 16:00:00', '2023-10-17 12:00:00', NOW(), NOW(), 1, 0, 3),
(4, 'Agencia D', '2023-10-18 17:00:00', '2023-10-18 13:00:00', NOW(), NOW(), 1, 0, 4),
(5, 'Agencia E', '2023-10-19 18:00:00', '2023-10-19 14:00:00', NOW(), NOW(), 1, 0, 5);

INSERT INTO `aeropuertos` (`id_aereopuertos`, `nombre_aeropuerto`, `ubicacion`, `created`, `modified`, `usuario_id`, `delete`)
VALUES 
(1, 'Aeropuerto Internacional JFK', 'Nueva York, USA', NOW(), NOW(), 1, 0),
(2, 'Aeropuerto Internacional LAX', 'Los Ángeles, USA', NOW(), NOW(), 1, 0),
(3, 'Aeropuerto Internacional MIA', 'Miami, USA', NOW(), NOW(), 1, 0),
(4, 'Aeropuerto Internacional SCL', 'Santiago, Chile', NOW(), NOW(), 1, 0),
(5, 'Aeropuerto Internacional EZE', 'Buenos Aires, Argentina', NOW(), NOW(), 1, 0);

INSERT INTO `metodo_pago` (`id_metodo_pago`, `nombre_metodo`, `descripcion_metodo`, `created`, `modified`, `usuario_id`, `delete`)
VALUES 
(1, 'Tarjeta de Crédito', 'Pago con tarjeta de crédito', NOW(), NOW(), 1, 0),
(2, 'PayPal', 'Pago a través de PayPal', NOW(), NOW(), 1, 0),
(3, 'Transferencia Bancaria', 'Pago por transferencia bancaria', NOW(), NOW(), 1, 0),
(4, 'Efectivo', 'Pago en efectivo', NOW(), NOW(), 1, 0),
(5, 'Criptomonedas', 'Pago con criptomonedas', NOW(), NOW(), 1, 0);

INSERT INTO `tarifa` (`id_tarifa`, `costo`, `descuento`, `created`, `modified`, `usuario_id`, `delete`, `id_metodo_pago`)
VALUES 
(1, 500, 50, NOW(), NOW(), 1, 0, 1),
(2, 700, 0, NOW(), NOW(), 1, 0, 2),
(3, 1000, 100, NOW(), NOW(), 1, 0, 3),
(4, 1200, 0, NOW(), NOW(), 1, 0, 4),
(5, 1500, 200, NOW(), NOW(), 1, 0, 5);

INSERT INTO `viajes` (`numero_vuelo`, `asientos`, `created`, `modified`, `usuario_id`, `delete`, `id_registro_viajes`, `origen`, `destino`, `id_tarifa`)
VALUES 
(101, 150, NOW(), NOW(), 1, 0, 1, 1, 2, 1),
(102, 200, NOW(), NOW(), 1, 0, 2, 2, 3, 2),
(103, 180, NOW(), NOW(), 1, 0, 3, 3, 4, 3),
(104, 220, NOW(), NOW(), 1, 0, 4, 4, 5, 4),
(105, 170, NOW(), NOW(), 1, 0, 5, 5, 1, 5);

INSERT INTO `usuarios_has_viajes` (`usuarios_id_usuarios`, `viajes_id_viajes`, `created`, `modified`, `usuario_id`, `delete`)
VALUES 
(1, 1, NOW(), NOW(), 1, 0),
(2, 2, NOW(), NOW(), 1, 0),
(3, 3, NOW(), NOW(), 1, 0),
(4, 4, NOW(), NOW(), 1, 0),
(5, 5, NOW(), NOW(), 1, 0);
USE clinica_veterinaria;

INSERT INTO dueños (nombre_dueño, rut, correo, direccion, telefono) VALUES
('Juan Perez', '111111111', 'juan@email.com', 'Calle Uno 123', '911111111'),
('Maria Lopez', '222222222', 'maria@email.com', 'Avenida Dos 456', '922222222'),
('Carlos Diaz', '333333333', 'carlos@email.com', 'Pasaje Tres 789', '933333333'),
('Ana Martinez', '444444444', 'ana@email.com', 'Camino Cuatro 101', '944444444'),
('Pedro Gomez', '555555555', 'pedro@email.com', 'Boulevard Cinco 202', '955555555'),
('Luisa Torres', '666666666', 'luisa@email.com', 'Ruta Seis 303', '966666666'),
('Miguel Soto', '777777777', 'miguel@email.com', 'Sendero Siete 404', '977777777'),
('Elena Rios', '888888888', 'elena@email.com', 'Paseo Ocho 505', '988888888'),
('Jorge Vega', '999999999', 'jorge@email.com', 'Avenida Nueve 606', '999999999'),
('Sofia Pino', '101010101', 'sofia@email.com', 'Camino Diez 707', '910101010');

INSERT INTO tipo_usuarios (nombre_tipo, descripcion_tipo) VALUES
('veterinario', 'Profesional encargado de la atencion medica de las mascotas en la clinica veterinaria'),
('dueño', 'Persona registrada como propietaria de una o mas mascotas en el sistema clinico'),
('recepcionista', 'Personal autorizado para gestionar citas y atender clientes en la clinica');

INSERT INTO usuarios (nombre_usuario, password, id_tipo_usuario, id_dueño, created_by) VALUES
('Doctor Smith', 'VetSecure123', 1, NULL, 1),
('Doctora Johnson', 'VetPass456', 1, NULL, 1),
('Doctor Williams', 'VetSafe789', 1, NULL, 1),
('Recepcionista Uno', 'Recep123Secure', 3, NULL, 1),
('Recepcionista Dos', 'Recep456Safe', 3, NULL, 1),
('Juan Perez', 'Dueño123Pass', 2, 1, 1),
('Maria Lopez', 'Dueño456Safe', 2, 2, 1),
('Carlos Diaz', 'Dueño789Secure', 2, 3, 1),
('Ana Martinez', 'Dueño101Pass', 2, 4, 1),
('Pedro Gomez', 'Dueño202Safe', 2, 5, 1);

INSERT INTO tipo_mascotas (especie, descripcion_especie) VALUES
('Perro', 'Animal domestico canino conocido por su lealtad y variedad de razas diferentes'),
('Gato', 'Felino domestico independiente que requiere cuidados especificos y atencion'),
('Conejo', 'Mamifero lagomorfo tranquilo que necesita espacio para ejercitarse diariamente');

INSERT INTO razas (raza, id_tipo_mascota) VALUES
('Labrador', 1),
('Pastor Aleman', 1),
('Bulldog', 1),
('Siames', 2),
('Persa', 2),
('Angora', 2),
('Holandes', 3),
('Mini Rex', 3),
('Cabeza de Leon', 3),
('Gigante de Flandes', 3);

INSERT INTO mascotas (nombre_mascota, comportamiento, fecha_nacimiento, sexo, id_dueño, id_raza) VALUES
('Max', 'Jugueton y amigable con otros perros y personas conocidas en el parque', '2020-05-15', 'macho', 1, 1),
('Luna', 'Timida al principio pero muy cariñosa cuando toma confianza con alguien', '2019-02-20', 'hembra', 2, 2),
('Rocky', 'Energetico y necesita mucho ejercicio diario para mantenerse calmado', '2021-07-10', 'macho', 3, 3),
('Milo', 'Tranquilo y le gusta dormir mucho durante el dia en su cama favorita', '2018-11-05', 'macho', 4, 4),
('Bella', 'Sociable y le encanta jugar con niños pequeños en el jardin', '2020-08-12', 'hembra', 5, 5),
('Charlie', 'Protector del hogar y muy leal a su familia humana principal', '2019-04-30', 'macho', 6, 6),
('Lola', 'Independiente pero afectuosa con su dueño cuando quiere atencion', '2020-01-25', 'hembra', 7, 7),
('Simba', 'Curioso y le gusta explorar cada rincon de la casa y jardin', '2019-09-15', 'macho', 8, 8),
('Coco', 'Tranquilo y disfruta de la compañia humana sin ser demandante', '2018-12-10', 'hembra', 9, 9),
('Thor', 'Energetico y necesita espacio para correr y gastar su energia', '2020-03-22', 'macho', 10, 10);

INSERT INTO diagnosticos (descripcion_diagnostico) VALUES
('Infeccion bacteriana en el tracto urinario que requiere tratamiento con antibioticos'),
('Dermatitis alergica causada por picaduras de pulgas necesita tratamiento topico'),
('Obesidad moderada que requiere cambio en dieta y aumento de actividad fisica'),
('Fractura en pata delantera derecha que necesita inmovilizacion y reposo'),
('Conjuntivitis viral con secrecion ocular que precisa gotas oftalmicas'),
('Problemas digestivos por cambio brusco de alimentacion necesita dieta blanda'),
('Artritis incipiente en cadera que requiere suplementos y ejercicio moderado'),
('Infeccion de oido con acumulacion de cera que necesita limpieza profesional'),
('Ansiedad por separacion que precisa modificacion de comportamiento'),
('Herida superficial por pelea con otro animal que requiere limpieza');

INSERT INTO consultas (fecha_consulta, motivo, id_diagnostico, id_mascota, id_usuario, created_by) VALUES
('2023-01-10', 'El perro presenta una urgencia para orinar y dolor abdominal persistente', 1, 1, 1, 1),
('2023-01-15', 'La mascota se rasca constantemente con perdida de pelo en varias zonas', 2, 2, 2, 1),
('2023-02-05', 'Control anual muestra una urgencia en el aumento de peso significativo que requiere atencion', 3, 3, 3, 1),
('2023-02-20', 'Accidente durante paseo con cojera evidente en pata delantera derecha', 4, 4, 1, 1),
('2023-03-12', 'Ojos rojos con secrecion persistente durante varios dias seguidos', 5, 5, 2, 1),
('2023-03-25', 'Problemas digestivos con vomitos y diarrea tras cambio de alimento', 6, 6, 3, 1),
('2023-04-08', 'Dificultad para levantarse y moverse especialmente por las mananas', 7, 7, 1, 1),
('2023-04-18', 'Sacudidas frecuentes de cabeza con mal olor proveniente de oidos', 8, 8, 2, 1),
('2023-05-03', 'Comportamiento destructivo cuando queda solo en casa por varias horas', 9, 9, 3, 1),
('2023-05-20', 'Herida visible en costado derecho aparentemente por pelea con otro animal', 10, 10, 1, 1);

INSERT INTO recetas (fecha_emision, id_consulta, created_by) VALUES
('2023-01-10 11:30:00', 1, 1),
('2023-01-15 16:45:00', 2, 2),
('2023-02-05 10:15:00', 3, 3),
('2023-02-20 14:20:00', 4, 1),
('2023-03-12 09:30:00', 5, 2),
('2023-03-25 12:10:00', 6, 3),
('2023-04-08 15:45:00', 7, 1),
('2023-04-18 11:20:00', 8, 2),
('2023-05-03 17:00:00', 9, 3),
('2023-05-20 10:30:00', 10, 1);

INSERT INTO medicamentos (nombre_medicamento, principio_activo) VALUES
('Amoxicilina Vet', 'Amoxicilina'),
('Prednisolona Oftalmica', 'Prednisolona'),
('Frontline Plus', 'Fipronil'),
('Rimadyl', 'Carprofeno'),
('Baytril', 'Enrofloxacina'),
('Metronidazol', 'Metronidazol'),
('Glucosamina Max', 'Glucosamina'),
('Otomax', 'Gentamicina'),
('Fluoxetina Vet', 'Fluoxetina'),
('Tramadol Vet', 'Tramadol');

INSERT INTO evaluaciones_medicas (id_receta, id_diagnostico, fecha_evaluacion, created_by) VALUES
(1, 1, '2023-01-17 10:00:00', 1),
(2, 2, '2023-01-22 16:30:00', 2),
(3, 3, '2023-02-12 11:15:00', 3),
(4, 4, '2023-02-27 09:45:00', 1),
(5, 5, '2023-03-19 14:20:00', 2),
(6, 6, '2023-04-02 10:30:00', 3),
(7, 7, '2023-04-15 15:10:00', 1),
(8, 8, '2023-04-25 11:45:00', 2),
(9, 9, '2023-05-10 17:30:00', 3),
(10, 10, '2023-05-27 10:15:00', 1);

INSERT INTO prescripciones (id_receta, id_medicamento, dosis, frecuencia, duracion, created_by) VALUES
(1, 1, 250, 2, 10, 1),
(2, 3, 1, 1, 30, 2),
(3, 4, 50, 1, 60, 3),
(4, 5, 100, 2, 14, 1),
(5, 2, 1, 4, 5, 2),
(6, 6, 200, 2, 7, 3),
(7, 7, 500, 1, 90, 1),
(8, 8, 3, 2, 10, 2),
(9, 9, 20, 1, 30, 3),
(10, 10, 50, 3, 5, 1);
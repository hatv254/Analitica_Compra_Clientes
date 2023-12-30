create table clientes(
	id int primary key not null,
	nombre text,
	direccion text,
	email text
);

create table productos(
	id int primary key not null,
	nombre text,
	descripcion text,
	precio decimal
);

create table ordenes(
	id int primary key not null,
	cliente_id int references clientes(id),
	producto_id int references productos(id),
	fecha timestamp,
	total decimal	
);

create table opiniones(
	id int primary key not null,
	producto_id int references productos(id),
	cliente_id int references clientes(id),
	opinion text
);

insert into clientes values (1,	'Juan Perez',	'Calle 123, Ciudad A',	'juan.perez@example.com')
,(2,	'Maria Lopez',	'Av. Principal, Ciudad B',	'maria.lopez@example.com')
,(3,	'Carlos Ramirez',	'Calle 456, Ciudad C',	'carlos.ramirez@example.com');

insert into productos values (1,	'Camiseta',	'Camiseta de algodon',	19.99),
(2,	'Pantalon',	'Pantalon de mezclilla',	39.99),
(3,	'Zapatos',	'Zapatos de cuero',	59.99);

insert into ordenes values (4,	1,	2,	'2023-06-01 09:00:00',	39.990),
(2,	2,	1,	'2023-06-02 15:30:00',	19.990),
(3,	3,	3,	'2023-06-03 11:45:00',	59.990);

insert into opiniones values (1,	1,	2,	'Me encanta esta camiseta'),
(2,	2,	1,	'Los pantalones son geniales'),
(3,	3,	3,	'Los zapatos son muy comodos');


'Obtener el nombre del cliente, nombre del producto y fecha de todas las órdenes realizadas (ordena por fecha de forma ascendente)'
select c.nombre as cliente, p.nombre as Producto, o.fecha as Fecha from ordenes o 
join clientes c on c.id = o.id
join productos p on p.id = o.id order by o.fecha asc;

'Calcular el total de ventas por cliente (ordena por total_ventas de forma ascendente)'
SELECT c.nombre, sum(o.total)
FROM ordenes o
JOIN clientes c ON o.cliente_id = c.id group by c.nombre order by sum(o.total) asc;

'Obtener el nombre del cliente y la cantidad de opiniones que ha realizado (ordena de forma ascendente por nombre_cliente)'
SELECT c.nombre AS nombre_cliente, COUNT(o.id) AS cantidad_opiniones
FROM clientes c
LEFT JOIN opiniones o ON c.id = o.cliente_id
GROUP BY c.nombre
ORDER BY c.nombre ASC;

'Obtener el nombre del producto y el número de opiniones recibidas, ordenados de 
forma ascendente por el número de opiniones (ordena por nombre_producto de forma ascendente)'
select pro.nombre, count(o.id) from opiniones o join productos pro on pro.id = o.producto_id group by pro.nombre order by pro.nombre asc;

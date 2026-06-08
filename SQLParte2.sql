
-- Practica Base De Datos - Ddl Y Dml
-- Universidad Americana
-- Sql Server
-- Parte 2: Desafios Adicionales (Puntos 81-90)


-- Recrear La Base De Datos Para Los Desafios
create database empresasql;
go

use empresasql;
go


-- Desafios Adicionales

-- 81. Crear Tabla Tcliente Con Al Menos 8 Campos Y Restricciones
create table tcliente (
    nclienteid int identity(1,1) primary key,
    cnif varchar(20) not null unique,
    cnombre varchar(100) not null,
    capellido varchar(100) not null,
    cemail varchar(150) unique,
    ctelefono varchar(20),
    cdireccion varchar(200),
    dfecharegistro date not null default getdate(),
    bactivo bit not null default 1,
    constraint ck_cliente_email check (cemail like '%@%.%')
);

-- 82. Crear Tabla Tventa Relacionada Con Tcliente
create table tventa (
    nventaid int identity(1,1) primary key,
    nclienteid int not null,
    dfechaventa datetime not null default getdate(),
    nmonto decimal(10,2) not null,
    cdescripcion varchar(200),
    cestado varchar(20) default 'Pendiente',
    constraint fk_venta_cliente foreign key (nclienteid) references tcliente(nclienteid),
    constraint ck_monto check (nmonto > 0),
    constraint ck_estado check (cestado in ('Pendiente', 'Pagada', 'Cancelada'))
);

-- 83. Registrar 20 Clientes
insert into tcliente (cnif, cnombre, capellido, cemail, ctelefono, cdireccion) values
('001-010101-1001a', 'Ana', 'Garcia', 'ana.garcia@mail.com', '8888-0001', 'Managua'),
('001-020202-1002b', 'Carlos', 'Lopez', 'carlos.lopez@mail.com', '8888-0002', 'Masaya'),
('001-030303-1003c', 'Beatriz', 'Martinez', 'beatriz.m@mail.com', '8888-0003', 'Granada'),
('001-040404-1004d', 'David', 'Hernandez', 'david.h@mail.com', '8888-0004', 'Chinandega'),
('001-050505-1005e', 'Elena', 'Perez', 'elena.p@mail.com', '8888-0005', 'Leon'),
('001-060606-1006f', 'Fernando', 'Ruiz', 'fernando.r@mail.com', '8888-0006', 'Managua'),
('001-070707-1007g', 'Gloria', 'Diaz', 'gloria.d@mail.com', '8888-0007', 'Rivas'),
('001-080808-1008h', 'Hugo', 'Torres', 'hugo.t@mail.com', '8888-0008', 'Matagalpa'),
('001-090909-1009i', 'Irene', 'Vargas', 'irene.v@mail.com', '8888-0009', 'Esteli'),
('001-101010-1010j', 'Jorge', 'Castillo', 'jorge.c@mail.com', '8888-0010', 'Jinotega'),
('001-111111-1011k', 'Karen', 'Nunez', 'karen.n@mail.com', '8888-0011', 'Managua'),
('001-121212-1012l', 'Luis', 'Morales', 'luis.m@mail.com', '8888-0012', 'Masaya'),
('001-131313-1013m', 'Marta', 'Salinas', 'marta.s@mail.com', '8888-0013', 'Granada'),
('001-141414-1014n', 'Nelson', 'Fuentes', 'nelson.f@mail.com', '8888-0014', 'Leon'),
('001-151515-1015o', 'Olga', 'Reyes', 'olga.r@mail.com', '8888-0015', 'Chinandega'),
('001-161616-1016p', 'Pablo', 'Mendoza', 'pablo.m@mail.com', '8888-0016', 'Managua'),
('001-171717-1017q', 'Quirina', 'Estrada', 'quirina.e@mail.com', '8888-0017', 'Rivas'),
('001-181818-1018r', 'Raul', 'Vega', 'raul.v@mail.com', '8888-0018', 'Matagalpa'),
('001-191919-1019s', 'Sandra', 'Arias', 'sandra.a@mail.com', '8888-0019', 'Esteli'),
('001-202020-1020t', 'Tomas', 'Ibarra', 'tomas.i@mail.com', '8888-0020', 'Managua');

-- 84. Registrar 50 Ventas
insert into tventa (nclienteid, dfechaventa, nmonto, cdescripcion, cestado) values
(1,  '2024-01-05', 250.00, 'Compra De Laptops', 'Pagada'),
(2,  '2024-01-10', 180.50, 'Accesorios De Oficina', 'Pagada'),
(3,  '2024-01-15', 320.75, 'Mobiliario De Escritorio', 'Pagada'),
(4,  '2024-01-20', 90.00,  'Materiales De Papeleria', 'Cancelada'),
(5,  '2024-02-01', 540.00, 'Equipo De Impresion', 'Pagada'),
(6,  '2024-02-05', 210.00, 'Sillas Ergonomicas', 'Pagada'),
(7,  '2024-02-10', 75.50,  'Suministros Varios', 'Pendiente'),
(8,  '2024-02-15', 480.00, 'Monitor 27 Pulgadas', 'Pagada'),
(9,  '2024-02-20', 130.00, 'Teclado Y Mouse', 'Pagada'),
(10, '2024-03-01', 650.00, 'Servidor De Red', 'Pagada'),
(1,  '2024-03-05', 95.00,  'Mantenimiento Mensual', 'Pagada'),
(2,  '2024-03-10', 375.00, 'Software De Gestion', 'Pagada'),
(3,  '2024-03-15', 200.00, 'Capacitacion Tecnica', 'Pendiente'),
(4,  '2024-03-20', 450.00, 'Equipo De Videoconferencia', 'Pagada'),
(5,  '2024-04-01', 115.00, 'Cable Utp Cat6', 'Pagada'),
(6,  '2024-04-05', 280.00, 'Switch De Red', 'Pagada'),
(7,  '2024-04-10', 520.00, 'Ups De Respaldo', 'Pagada'),
(8,  '2024-04-15', 60.00,  'Cartuchos De Tinta', 'Cancelada'),
(9,  '2024-04-20', 340.00, 'Disco Duro Externo', 'Pagada'),
(10, '2024-05-01', 780.00, 'Router Empresarial', 'Pagada'),
(11, '2024-05-05', 430.00, 'Impresora Multifuncional', 'Pagada'),
(12, '2024-05-10', 160.00, 'Tarjetas De Memoria', 'Pagada'),
(13, '2024-05-15', 290.00, 'Proyector Portatil', 'Pendiente'),
(14, '2024-05-20', 195.00, 'Auriculares Con Microfono', 'Pagada'),
(15, '2024-06-01', 860.00, 'Workstation Para Diseno', 'Pagada'),
(16, '2024-06-05', 110.00, 'Mousepad Xl', 'Pagada'),
(17, '2024-06-10', 670.00, 'Tablet Grafica', 'Pagada'),
(18, '2024-06-15', 215.00, 'Hub Usb 7 Puertos', 'Pagada'),
(19, '2024-06-20', 390.00, 'Monitor Secundario', 'Pagada'),
(20, '2024-07-01', 480.00, 'Ssd 1tb', 'Pagada'),
(1,  '2024-07-05', 155.00, 'Licencia Antivirus', 'Pagada'),
(2,  '2024-07-10', 720.00, 'Laptop Gamer', 'Pagada'),
(3,  '2024-07-15', 230.00, 'Base De Refrigeracion', 'Pendiente'),
(4,  '2024-07-20', 310.00, 'Ram 32gb', 'Pagada'),
(5,  '2024-08-01', 180.00, 'Cable Hdmi 4k', 'Pagada'),
(6,  '2024-08-05', 550.00, 'Impresora 3d Basica', 'Pagada'),
(7,  '2024-08-10', 440.00, 'Camara Web Full Hd', 'Pagada'),
(8,  '2024-08-15', 95.00,  'Mochila Para Laptop', 'Cancelada'),
(9,  '2024-08-20', 630.00, 'Licencia Office Anual', 'Pagada'),
(10, '2024-09-01', 270.00, 'Soporte Para Monitor', 'Pagada'),
(11, '2024-09-05', 410.00, 'Teclado Mecanico', 'Pagada'),
(12, '2024-09-10', 185.00, 'Adaptador Multipuerto', 'Pagada'),
(13, '2024-09-15', 920.00, 'Laptop Profesional', 'Pagada'),
(14, '2024-09-20', 145.00, 'Powerbank 20000mah', 'Pendiente'),
(15, '2024-10-01', 760.00, 'Tablet 11 Pulgadas', 'Pagada'),
(16, '2024-10-05', 330.00, 'Audifonos Bluetooth', 'Pagada'),
(17, '2024-10-10', 500.00, 'Pc All In One', 'Pagada'),
(18, '2024-10-15', 225.00, 'Kit De Limpieza', 'Pagada'),
(19, '2024-10-20', 870.00, 'Monitor Ultrawide', 'Pagada'),
(20, '2024-11-01', 355.00, 'Pendrive 128gb X5', 'Pagada');

-- 85. Actualizar Montos De Ventas Segun Condicion (Aumentar 5% Las Ventas Pendientes)
update tventa
set nmonto = nmonto * 1.05
where cestado = 'Pendiente';

-- 86. Eliminar Clientes Sin Ventas
delete from tcliente
where nclienteid not in (
    select distinct nclienteid from tventa
);

-- 87. Los 5 Clientes Con Mayores Compras
select top 5
    c.cnombre,
    c.capellido,
    sum(v.nmonto) as totalcompras
from tcliente c
inner join tventa v on c.nclienteid = v.nclienteid
where v.cestado = 'Pagada'
group by c.nclienteid, c.cnombre, c.capellido
order by totalcompras desc;

-- 88. Ventas Por Mes
select
    year(dfechaventa) as anio,
    month(dfechaventa) as mes,
    datename(month, dfechaventa) as nombremes,
    count(*) as cantidadventas,
    sum(nmonto) as totalventas
from tventa
group by year(dfechaventa), month(dfechaventa), datename(month, dfechaventa)
order by anio, mes;

-- 89. Promedio De Ventas Por Cliente
select
    c.cnombre,
    c.capellido,
    count(v.nventaid) as cantidadventas,
    avg(v.nmonto) as promediomonto
from tcliente c
inner join tventa v on c.nclienteid = v.nclienteid
group by c.nclienteid, c.cnombre, c.capellido
order by promediomonto desc;

-- 90. Reporte Consolidado Con Join Entre Tres Tablas
select
    c.cnombre + ' ' + c.capellido as cliente,
    c.cdireccion as ciudad,
    convert(varchar, v.dfechaventa, 103) as fechaventa,
    v.nmonto,
    v.cdescripcion,
    v.cestado
from tcliente c
inner join tventa v on c.nclienteid = v.nclienteid
order by c.capellido, v.dfechaventa;
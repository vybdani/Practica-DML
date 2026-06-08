
-- Practica Base De Datos - Ddl Y Dml
-- Universidad Americana
-- Sql Server
-- Parte 1: Creacion, Modificacion, Insercion, Actualizacion,
--          Eliminacion, Consultas Y Administracion De Objetos




-- Parte I. Creacion De Base De Datos Y Tablas (Ddl)

-- 1. Crear Base De Datos
create database empresasql;
go

-- 2. Seleccionar La Base De Datos
use empresasql;
go

-- 3. Crear Tabla Tdepartamento
create table tdepartamento (
    ndepartamentoid int identity(1,1) primary key,
    cnombredepartamento varchar(100) not null unique
);

-- 4. Crear Tabla Tcargo
create table tcargo (
    ncargoid int identity(1,1) primary key,
    cnombrecargo varchar(100) not null unique
);

-- 5. Crear Tabla Templeado
create table templeado (
    nempleadoid int identity(1,1) primary key,
    cnif varchar(20) unique,
    cnombre varchar(50),
    capellido varchar(50),
    ndepartamentoid int,
    ncargoid int,
    dfechacontratacion date,
    nsalario decimal(10,2)
);

-- 6. Restriccion Check Para Salario Mayor A 300
alter table templeado
add constraint ck_salario check (nsalario > 300);

-- 7. Restriccion Default Para Fecha De Contratacion
alter table templeado
add constraint df_fechacontratacion default getdate() for dfechacontratacion;

-- 8. Llave Foranea Templeado -> Tdepartamento
alter table templeado
add constraint fk_empleado_departamento
foreign key (ndepartamentoid) references tdepartamento(ndepartamentoid);

-- 9. Llave Foranea Templeado -> Tcargo
alter table templeado
add constraint fk_empleado_cargo
foreign key (ncargoid) references tcargo(ncargoid);

-- 10. Crear Tabla Tproyecto
create table tproyecto (
-- 11. Clave Primaria Autoincremental
    nproyectoid int identity(1,1) primary key,
-- 12. Nombre Del Proyecto Obligatorio
    cnombreproyecto varchar(150) not null,
-- 13. Fecha De Inicio Obligatoria
    dfechainicio date not null,
-- 14. Fecha De Finalizacion (Opcional)
    dfechafin date
);

-- 15. Tabla Intermedia Templeadoproyecto (Muchos A Muchos)
create table templeadoproyecto (
    nempleadoid int not null,
    nproyectoid int not null,
    primary key (nempleadoid, nproyectoid),
    constraint fk_ep_empleado foreign key (nempleadoid) references templeado(nempleadoid),
    constraint fk_ep_proyecto foreign key (nproyectoid) references tproyecto(nproyectoid)
);



-- Parte II. Modificacion De Estructuras (Alter)

-- 16. Agregar Columna Cemail A Templeado
alter table templeado
add cemail varchar(150);

-- 17. Agregar Columna Ctelefono
alter table templeado
add ctelefono varchar(15);

-- 18. Modificar Longitud De Cnombre A 100
alter table templeado
alter column cnombre varchar(100);

-- 19. Modificar Longitud De Capellido A 100
alter table templeado
alter column capellido varchar(100);

-- 20. Agregar Columna Cdireccion
alter table templeado
add cdireccion varchar(200);

-- 21. Agregar Columna Nedad
alter table templeado
add nedad int;

-- 22. Restriccion Check Para Edad Entre 18 Y 65
alter table templeado
add constraint ck_edad check (nedad between 18 and 65);

-- 23. Restriccion Unique Al Correo Electronico (Indice Filtrado Para Ignorar Nulls)
create unique index uq_email on templeado(cemail)
where cemail is not null;

-- 24. Columna Bactivo Tipo Bit Con Default 1
alter table templeado
add bactivo bit not null constraint df_activo default 1;

-- 25. Eliminar Columna Cdireccion
alter table templeado
drop column cdireccion;

-- 26. Cambiar Tipo De Dato De Ctelefono A Varchar(20)
alter table templeado
alter column ctelefono varchar(20);

-- 27. Agregar Columna Cgenero
alter table templeado
add cgenero char(1);

-- 28. Restriccion Check Para Genero Solo M O F
alter table templeado
add constraint ck_genero check (cgenero in ('m', 'f'));

-- 29. Agregar Columna Dfechanacimiento
alter table templeado
add dfechanacimiento date;

-- 30. Crear Tabla Tsucursal
create table tsucursal (
    nsucursalid int identity(1,1) primary key,
    cnombresucursal varchar(100) not null,
    cciudad varchar(100),
    ctelefono varchar(20)
);


-- Parte III. Insercion De Datos (Insert)

-- 31. Insertar 5 Departamentos
insert into tdepartamento (cnombredepartamento) values
('Tecnologia'),
('Recursos Humanos'),
('Finanzas'),
('Marketing'),
('Operaciones');

-- 32. Insertar 5 Cargos
insert into tcargo (cnombrecargo) values
('Gerente'),
('Analista'),
('Desarrollador'),
('Contador'),
('Disenador');

-- 33. Insertar 10 Empleados
insert into templeado (cnif, cnombre, capellido, ndepartamentoid, ncargoid, dfechacontratacion, nsalario, cemail, nedad, cgenero, dfechanacimiento)
values
('001-010101-0001a', 'Carlos', 'Garcia', 1, 3, '2020-01-15', 1200.00, 'cgarcia@empresa.com', 30, 'm', '1994-03-10'),
('001-020202-0002b', 'Laura', 'Martinez', 2, 2, '2019-05-20', 950.00, 'lmartinez@empresa.com', 28, 'f', '1996-07-22'),
('001-030303-0003c', 'Pedro', 'Lopez', 3, 4, '2021-03-10', 1100.00, 'plopez@empresa.com', 35, 'm', '1989-11-05'),
('001-040404-0004d', 'Ana', 'Rodriguez', 4, 5, '2022-07-01', 800.00, 'arodriguez@empresa.com', 26, 'f', '1998-02-14'),
('001-050505-0005e', 'Jose', 'Hernandez', 1, 3, '2018-09-15', 1500.00, 'jhernandez@empresa.com', 40, 'm', '1984-06-30'),
('001-060606-0006f', 'Maria', 'Perez', 5, 2, '2023-02-01', 700.00, 'mperez@empresa.com', 24, 'f', '2000-08-18'),
('001-070707-0007g', 'Luis', 'Gonzalez', 2, 1, '2017-11-10', 2000.00, 'lgonzalez@empresa.com', 45, 'm', '1979-04-25'),
('001-080808-0008h', 'Sofia', 'Diaz', 3, 4, '2020-06-20', 1050.00, 'sdiaz@empresa.com', 32, 'f', '1992-09-12'),
('001-090909-0009i', 'Jorge', 'Ruiz', 4, 2, '2021-08-05', 880.00, 'jruiz@empresa.com', 29, 'm', '1995-12-01'),
('001-101010-0010j', 'Elena', 'Torres', 5, 5, '2022-04-18', 750.00, 'etorres@empresa.com', 27, 'f', '1997-05-07');

-- 34. Insertar 3 Proyectos
insert into tproyecto (cnombreproyecto, dfechainicio, dfechafin) values
('Sistema De Gestion Interna', '2024-01-01', '2024-12-31'),
('Rediseno Web Corporativo', '2024-03-15', '2024-09-30'),
('Migracion A La Nube', '2024-06-01', null);

-- 35. Asignar Empleados A Proyectos
insert into templeadoproyecto (nempleadoid, nproyectoid) values
(1, 1), (2, 1), (3, 2), (4, 2), (5, 3),
(6, 3), (7, 1), (8, 2), (9, 3), (10, 1);

-- 36. Insertar Empleado Usando Default De Fecha
insert into templeado (cnif, cnombre, capellido, ndepartamentoid, ncargoid, nsalario, nedad, cgenero)
values ('001-111111-0011k', 'Roberto', 'Nunez', 1, 2, 900.00, 33, 'm');

-- 37. Insertar Empleado Con Correo Electronico
insert into templeado (cnif, cnombre, capellido, ndepartamentoid, ncargoid, dfechacontratacion, nsalario, cemail, nedad, cgenero)
values ('001-121212-0012l', 'Patricia', 'Vargas', 2, 5, '2023-05-10', 820.00, 'pvargas@empresa.com', 31, 'f');

-- 38. Insertar Empleado Sin Indicar Estado Activo (Usara Default = 1)
insert into templeado (cnif, cnombre, capellido, ndepartamentoid, ncargoid, dfechacontratacion, nsalario, nedad, cgenero)
values ('001-131313-0013m', 'Miguel', 'Castillo', 3, 3, '2023-09-01', 1300.00, 38, 'm');

-- 39. Insertar Multiples Registros Con Un Solo Insert
insert into tdepartamento (cnombredepartamento) values
('Logistica'),
('Legal');


-- Parte IV. Actualizacion De Datos (Update)

-- 41. Incrementar 10% El Salario De Todos Los Empleados
update templeado
set nsalario = nsalario * 1.10;

-- 42. Incrementar 20% El Salario Del Departamento De Tecnologia (Id = 1)
update templeado
set nsalario = nsalario * 1.20
where ndepartamentoid = 1;

-- 43. Actualizar Correo De Un Empleado Especifico
update templeado
set cemail = 'carlos.garcia@empresa.com'
where cnif = '001-010101-0001a';

-- 44. Modificar El Cargo De Un Empleado
update templeado
set ncargoid = 1
where cnif = '001-020202-0002b';

-- 45. Cambiar Departamento De Dos Empleados
update templeado
set ndepartamentoid = 3
where cnif in ('001-060606-0006f', '001-090909-0009i');

-- 46. Marcar Inactivos A Empleados Con Salario Inferior A 500
update templeado
set bactivo = 0
where nsalario < 500;

-- 47. Actualizar Fecha De Finalizacion De Un Proyecto
update tproyecto
set dfechafin = '2025-03-31'
where nproyectoid = 3;

-- 48. Asignar Un Nuevo Proyecto A Un Empleado
insert into templeadoproyecto (nempleadoid, nproyectoid)
values (3, 3);


-- Parte V. Eliminacion De Datos (Delete)

-- 49. Eliminar Empleado Por Su Nif
delete from templeadoproyecto
where nempleadoid = (select nempleadoid from templeado where cnif = '001-131313-0013m');

delete from templeado
where cnif = '001-131313-0013m';

-- 50. Eliminar Todos Los Empleados Inactivos
delete from templeadoproyecto
where nempleadoid in (select nempleadoid from templeado where bactivo = 0);

delete from templeado
where bactivo = 0;

-- 51. Eliminar Un Proyecto Especifico
delete from templeadoproyecto
where nproyectoid = 2;

delete from tproyecto
where nproyectoid = 2;

-- 52. Eliminar Asignaciones De Un Empleado En Templeadoproyecto
delete from templeadoproyecto
where nempleadoid = 5;

-- 53. Eliminar Un Departamento Sin Empleados Asociados
delete from tdepartamento
where ndepartamentoid not in (
    select distinct ndepartamentoid from templeado where ndepartamentoid is not null
);


-- Parte VI. Consultas De Verificacion

-- 54. Todos Los Empleados Ordenados Por Apellido
select * from templeado
order by capellido;

-- 55. Empleados Con Salario Mayor A 1000
select * from templeado
where nsalario > 1000;

-- 56. Empleados Activos
select * from templeado
where bactivo = 1;

-- 57. Empleados Contratados En El Ano Actual
select * from templeado
where year(dfechacontratacion) = year(getdate());

-- 58. Empleados Con Nombre De Departamento
select e.nempleadoid, e.cnombre, e.capellido, d.cnombredepartamento
from templeado e
inner join tdepartamento d on e.ndepartamentoid = d.ndepartamentoid;

-- 59. Empleados Con Nombre De Cargo
select e.nempleadoid, e.cnombre, e.capellido, c.cnombrecargo
from templeado e
inner join tcargo c on e.ncargoid = c.ncargoid;

-- 60. Empleados Asignados A Proyectos
select e.cnombre, e.capellido, p.cnombreproyecto
from templeado e
inner join templeadoproyecto ep on e.nempleadoid = ep.nempleadoid
inner join tproyecto p on ep.nproyectoid = p.nproyectoid;

-- 61. Cantidad De Empleados Por Departamento
select d.cnombredepartamento, count(e.nempleadoid) as totalempleados
from tdepartamento d
left join templeado e on d.ndepartamentoid = e.ndepartamentoid
group by d.cnombredepartamento;

-- 62. Salario Promedio Por Departamento
select d.cnombredepartamento, avg(e.nsalario) as salariopromededio
from tdepartamento d
inner join templeado e on d.ndepartamentoid = e.ndepartamentoid
group by d.cnombredepartamento;

-- 63. Salario Maximo Y Minimo Por Departamento
select d.cnombredepartamento,
       max(e.nsalario) as salariumaximo,
       min(e.nsalario) as salariominimo
from tdepartamento d
inner join templeado e on d.ndepartamentoid = e.ndepartamentoid
group by d.cnombredepartamento;

-- 64. Proyectos Con Mas De Dos Empleados Asignados
select p.cnombreproyecto, count(ep.nempleadoid) as totalempleados
from tproyecto p
inner join templeadoproyecto ep on p.nproyectoid = ep.nproyectoid
group by p.cnombreproyecto
having count(ep.nempleadoid) > 2;

-- 65. Empleados Cuyo Apellido Inicia Con G
select * from templeado
where capellido like 'g%';

-- 66. Empleados Ordenados Por Salario Descendente
select * from templeado
order by nsalario desc;

-- 67. Los Tres Salarios Mas Altos
select top 3 * from templeado
order by nsalario desc;

-- 68. Empleados Con Edad Entre 25 Y 40 Anos
select * from templeado
where nedad between 25 and 40;

-- 69. Cantidad Total De Empleados Activos
select count(*) as totalactivos from templeado
where bactivo = 1;

-- 70. Total De Proyectos Registrados
select count(*) as totalproyectos from tproyecto;


-- Parte VII. Administracion De Objetos

-- 71. Eliminar Restriccion Check De Edad
alter table templeado
drop constraint ck_edad;

-- 72. Eliminar Restriccion Unique Del Correo
drop index uq_email on templeado;

-- 73. Agregar Nuevamente Ambas Restricciones
alter table templeado
add constraint ck_edad check (nedad between 18 and 65);

create unique index uq_email on templeado(cemail)
where cemail is not null;

-- 74. Eliminar Tabla Templeadoproyecto
drop table templeadoproyecto;

-- 75. Eliminar Tabla Tproyecto
drop table tproyecto;

-- 76. Eliminar Tabla Templeado
drop table templeado;

-- 77. Eliminar Tabla Tcargo
drop table tcargo;

-- 78. Eliminar Tabla Tdepartamento
drop table tdepartamento;

-- 79. Eliminar Tabla Tsucursal
drop table tsucursal;

-- 80. Eliminar La Base De Datos
use master;
drop database empresasql;
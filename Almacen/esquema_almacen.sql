
create or replace procedure guardar_almacen( --Argumento solo si se requiere
  my_num_alm in integer,
  my_ub_alm in varchar2
  )
    as --variables locales
    begin
      insert into almacen values(my_num_alm,my_ub_alm);
    end;
  /

--usaremos un bloque PL-SQL para probar que está bien nuestro procedimiento
begin
  guardar_almacen(12,'Ecaatepecs');
end;
/

Select * from almacen;

--probarel procedimiento con netbeans


--Crear relación de tablas 
create table almacen(
  num_almacen integer,
  ubicacion_almacen varchar(30),
  constraint pk_num_almacen primary key (num_almacen)
  );

create table cliente(
  num_cliente integer,
  nombre_cliente varchar2(50),
  num_almacen integer,
  constraint pk_num_cliente primary key (num_cliente)
  );
 --drop table vendedor
 --select * from vendedor
create table vendedor(
  num_vendedor integer,
  nombre_vendedor varchar2(50),
  --
  constraint pk_num_vendedor primary key (num_vendedor)
  );

create table ventas(
  id_ventas integer,
  area_ventas varchar2(50),
  monto_ventas float,
  num_cliente integer,
  num_vendedor integer,
  constraint pk_id_ventas primary key (id_ventas)
  );
  
alter table cliente 
  add constraint fk_clinte_almacen foreign key (num_almacen)
  references almacen (num_almacen);
  
alter table ventas
  add constraint fk_ventas_cliente foreign key (num_cliente) --fk1_n_cl
  references cliente (num_cliente);
  
alter table ventas
  add constraint fk_ventas_vendedor foreign key (num_vendedor) --fk1_id_v
  references vendedor (num_vendedor); 
  

--Crear procedimientos almacenados para las tablas restantes
/*
Pasos para guardar una fila o registro con PK impuesto.
  1.- Generar secuencia
  2.-Generar el procedimiento y asociarlo
*/
--entregable 3: Crear procedimientos almacenados para llas tablas restantes

create or replace procedure guardar_cliente(
  my_num_cliente in integer,
  my_nombre_cliente in varchar2,
  my_num_almacen in integer)
    as
    
    begin
      insert into cliente values (my_num_cliente,my_nombre_cliente,my_num_almacen);
    end;
  /
  
create or replace procedure guardar_vendedor(
  my_num_vendedor in integer,
  my_nombre_vendedor in varchar2)
  as
  
  begin
    insert into vendedor values(my_num_vendedor,my_nombre_vendedor);
  end;
/


--secuencia para id_ventas
create SEQUENCE sec_ventas
  start with 1
  increment by 1
  nomaxvalue;

create or replace procedure guardar_ventas(
  my_id_ventas out integer,
  my_area_ventas in varchar2,
  my_monto_ventas in float,
  my_num_cliente in integer,
  my_num_vendedor in integer
  )
  as
  
  begin
    select sec_ventas.nextval into my_id_ventas from dual;
    insert into ventas values(my_id_ventas,my_area_ventas, my_monto_ventas,my_num_cliente,my_num_vendedor);
  end;
/
--Introducir datos del excel en la BD mediante los procedimientos almacedos

begin
  guardar_vendedor(3462,'Waters');
  guardar_vendedor(3593,'Dryone');
end;
/

begin
  guardar_almacen(1,'Plymouth');
  guardar_almacen(2,'Superior');
  guardar_almacen(3,'Bismarck');
  guardar_almacen(4,'Fargo');
end;
/

begin
  guardar_cliente(18765,'Delta Systems',4);
  guardar_cliente(18830,'A. Levy and Sons',3);
  guardar_cliente(19242,'Rainer Company',3);
  guardar_cliente(18841,'R. W. Flood Inc.',2);
  guardar_cliente(18899,'Seward Systems',2);
  guardar_cliente(19565,'Stodolas Inc.',1);
end;
/

declare
  venta integer;
begin 
  GUARDAR_VENTAS(venta,'West',3728,18765,3462);
  guardar_ventas(venta,'West',13540.0,18765,3462);
  guardar_ventas(venta,'West',10600.0,18830,3462);
  guardar_ventas(venta,'West',9700.0,19242,3462);
  guardar_ventas(venta,'East',11560.0,18841,3593);
  guardar_ventas(venta,'East',2590.0,18899,3593);
  guardar_ventas(venta,'East',8800.0,19565,3593);
end;
/

--cursor de referencia
--usado para comunicación entre sistemas
create or replace procedure obtener_almacen(
  cur_almacen out sys_refcursor)
  as
  begin
    open cur_almacen for select * from almacen;
  end;
  /

select * from almacen;
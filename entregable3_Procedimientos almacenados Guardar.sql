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

declare
  venta integer;
begin --area,monto,cliente,vendedor
  guardar_ventas(venta,'West',13540.0,18765,3462);
  guardar_ventas(venta,'West',10600.0,18830,3462);
  guardar_ventas(venta,'West',9700.0,19242,3462);
  guardar_ventas(venta,'East',11560.0,18841,3593);
  guardar_ventas(venta,'East',2590.0,18899,3593);
  guardar_ventas(venta,'East',8800.0,19565,3593);
end;
/


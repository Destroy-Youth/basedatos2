/*
create table almacen(
numero_almacen integer,
ubicacion_almacen varchar2(50),
constraint pk2_num_almacen primary key (numero_almacen)
);
*/

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


--Crear relación de tablas create table almacen(
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
create table vendedor(
  num_vendedor integer,
  nombre_vendedor varchar2(50),
  area_ventas varchar2(50),
  constraint pk_num_vendedor primary key (num_vendedor)
  );

create table ventas(
  id_ventas integer,
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
  
--alter table vendedor add area_ventas varchar2(59);

--Crear procedimientos almacenados para las tablas restantes
/*
Pasos para guardar una fila o registro con PK impuesto.
  1.- Generar secuencia
  2.-Generar el procedimiento y asociarlo
  
  
  Ejemplo:
*/
create table calificaciones(
  id_calificacion integer,
  materia varchar2(50),
  valor float,
  constraint pk_id_cali primary key(id_calificacion)
  );

--gENERAR SECUENCIA
create sequence sec_calificaciones
  start with 1
  increment by 1
  nomaxvalue;
  
--Aquí ya viene el procedimiento almacenado
/*
Cursores: Sentencias SQL que se puede congelar y operar sobre ella

  -Explicitos: Cuando se usa un select complejo, devolviendo numerosos datos por fila
  -Implicitos: Cuando se hace un select simple, que solo devuelve un solo valor

*/

create or replace procedure guardar_calificaciones(
  my_id_calificacion out integer,
  my_materia in varchar2(48),
  my_valor in float  
  )
  as
  begin                                 --into -> cursor implicito,  DUAL = tabla virtual nacido de la secuencia en el cursor
    select sec_calificaciones.nextval into my_id_calificacion from dual; --nextval indica la poscicion, deposita el resultado en el id, 
    insert into calificaciones values(my_id_calificacion,my_materia,my_valor);
  end;
/
  
  
  

create or replace procedure guardar_cliente


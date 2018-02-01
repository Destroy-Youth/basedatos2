create table almacen(
numero_almacen integer,
ubicacion_almacen varchar2(50),
constraint pk2_num_almacen primary key (numero_almacen)
);

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

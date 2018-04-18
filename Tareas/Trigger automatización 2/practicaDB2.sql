--PRactica automatización
--drop table profesor;
create table profesor(
  id_profesor varchar(9) primary key,
  nombre varchar(60),
  materia integer);
  
create table registro(
  id_registro integer primary key,
  id_profesor varchar(9),
  entrada varchar(60));
  
create table alumno(
  id_alumno varchar(9) primary key,
  nombre varchar (60),
  materia integer,
  calificacion float,
  estatus varchar(10));
  
create table materia(
  id_materia integer primary key,
  nombre varchar (80)
  );
  
--Creación de foreign keys  
alter table profesor
  add constraint fk1_profesor_materia
  foreign key (materia)
  references materia(id_materia);

alter table registro
  add constraint fk1_registro_profesor
  foreign key (id_profesor)
  references profesor (id_profesor);
  
alter table alumno
  add constraint fk1_alumno_materia
  foreign key (materia)
  references materia (id_materia);

--creación de secuencia para la materia y registros
create sequence sec_materia
  start with 1
  increment by 1
  nomaxvalue;
  
create sequence sec_registro
  start with 1
  increment by 1
  nomaxvalue;

--procedimiento almacenado para guardar
create or replace procedure guardar_materia(
  my_id out integer,
  my_nombre in varchar)
  as
  begin
    select sec_materia.nextval into my_id from dual;
    insert into materia values (my_id,my_nombre);
  end;
  /
  select  * from profesor;

create or replace procedure guardar_profesor(
  my_id in varchar,
  my_nombre in varchar,
  my_materia in integer)
  as
  begin
    insert into profesor values (my_id,my_nombre,my_materia);
  end;
/

create or replace procedure guardar_registro(
  my_id out integer,
  my_profesor in varchar,
  my_entrada out char)
  as
  valor char(60);
  begin
    valor:=to_char(sysdate,'DD-MON-YYYY HH:MI:SS');
    my_entrada:=valor;
    select sec_registro.nextval into my_id from dual;
    insert into registro values(my_id,my_profesor,my_entrada);
  end;
/

create or replace procedure guardar_alumno1(
  my_id in varchar,
  my_nombre in varchar,
  my_materia in integer,
  my_calificacion in float)
  as
  begin
    insert into alumno (id_alumno,nombre,materia,calificacion)
      values(my_id,my_nombre,my_materia,my_calificacion);
  end;
/


create or replace procedure guardar_alumno2(
  my_id in varchar,
  my_nombre in varchar,
  my_materia in integer,
  my_calificacion in float)
  as
  begin
  if my_calificacion < 6 then
    insert into alumno (id_alumno,nombre,materia,calificacion,estatus)
      values(my_id,my_nombre,my_materia,my_calificacion,'Reprobado');
  else
    insert into alumno (id_alumno,nombre,materia,calificacion,estatus)
      values(my_id,my_nombre,my_materia,my_calificacion,'Aprobado');
  end if;
  end;
/

create or replace procedure update_alumno(
  my_id in varchar,
  my_calif in varchar)
  as
  begin
  if my_calif < 6 then
    update alumno set calificacion=my_calif,
                      estatus='Reprobado'
      where  id_alumno=my_id;
  else
        update alumno set calificacion=my_calif,
                      estatus='Aprobado'
      where  id_alumno=my_id;
  end if;
  end;
/
  
--creación de disparadores
create or replace trigger disp_entrada before insert on registro
  for each row
  declare
    minuto char(40);
  begin
    minuto:=to_char(sysdate,'mi');
    if to_number(minuto) > 15 then
      raise_application_error(-20001,'Ha llegado tarde!, no se puede regitrar');
    else
      DBMS_OUTPUT.PUT_LINE('Registrado!');
    end if;
  end;
  /

create or replace trigger disp_calificacion before update on alumno
  for each row
  declare
  begin
      if :new.calificacion < 6 then
        update alumno set estatus='Reprobado' where :old.id_alumno=:new.id_alumno;
      else
        update alumno set estatus='Aprobado' where :old.id_alumno=:new.id_alumno;
      end if;
    end;
  /
    
drop trigger disp_calificacion;


declare
  valor integer;
begin
  guardar_materia(valor,'Programación');
end;
/
select * from materia;

begin
  guardar_profesor('1234565','Juan López',1);
end;
/
select * from profesor;

--Prueba de registros
declare
v1 integer;
valor char(60);
  begin
  guardar_registro(v1,'1234567',valor);
end;
/

--Prueba de reprobar
declare
begin
  guardar_alumno2('123456','MAría Sanchez',1,8.5);
end;
/

declare
begin
  update_alumno('123456',4.3);
end;
/
  
select * from alumno;
select * from materia;
select * from profesor;
select * from registro;

drop trigger disp_calificacion;
create or replace trigger disp_respaldo after insert on comprador
  for each row
  declare 
    begin
    insert into respaldo_comprador values (:new.id_comprador,:new.nombre,:new.monto);
    end;
  /
  
create or replace trigger disp_borrar before insert on respaldo_comprador
  for each row
  declare
    cuenta integer;
    modulo float; 
  begin 
    select :new.id_comprador into cuenta from comprador;
    modulo:=mod(cuenta,3);
      if modulo > 0 then      
        delete from comprador;
      end if;
      
    end;
  /
  
  drop trigger disp_borrar;
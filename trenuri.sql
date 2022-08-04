create or replace package traseu as

    v_id1 integer;
    v_id2 integer;
    v_id_statie1 integer;
    v_id_statie2 integer;
    v_id_tren1 integer;
    v_id_tren2 integer;
    v_id_tren integer;
    v_exists integer;
    v_nume_tren varchar2(100);
    v_min_plec integer;
    v_min_sos integer;
    v_ora_sos integer;
    v_ora_plec integer;
    v_rez varchar2(10000);
    v_rez2 varchar2(10000);
    TYPE varr IS table OF pls_integer;
    bfs varr;
    ora integer;
    min integer;
    cursor cursor_trenuri(v_id1 integer) is select id_tren from trasee where id_statie1=v_id1;
    cursor cursor_trenuri1(v_id1 integer) is select id_tren,ordine from trasee where id_statie1=v_id1;
    cursor cursor_trenuri2(v_id2 integer) is select id_tren,ordine from trasee where id_statie2=v_id2;
    cursor cursor_statii1(v_id_tren1 integer, v_ordine1 integer) is select id_statie2 from trasee where id_tren=v_id_tren1 and ordine>=v_ordine1;
    cursor cursor_statii2(v_id_tren2 integer, v_ordine2 integer) is select id_statie1 from trasee where id_tren=v_id_tren2 and ordine<=v_ordine2;
    cursor cursor_bfs(v_id1 integer) is select id_statie2 from trasee where id_statie1=v_id1;
    v_contor integer;
    v_nume_statie varchar2(100);
    ordine1 integer;
    ordine2 integer;
    found boolean;
    found2 boolean;
    function traseu_direct (statie1 varchar2,statie2 varchar2) return varchar2;
    function statii_traseu(statie1 varchar2,statie2 varchar2, tren varchar2) return varchar2;
    procedure traseu_schimbare (statie1 varchar2, statie2 varchar2);
    procedure statii_bfs (statie1 varchar2, statie2 varchar2);

end traseu;







CREATE OR REPLACE PACKAGE BODY traseu is

function traseu_direct (statie1 varchar2,statie2 varchar2) 
return varchar2 AS
BEGIN
v_rez:='';
if cursor_trenuri%isopen=true then
  close cursor_trenuri;
end if;
   select id into v_id1 from statii where nume=statie1;
   select id into v_id2 from statii where nume=statie2;
   open cursor_trenuri(v_id1);
   LOOP
        FETCH cursor_trenuri INTO v_id_tren;
        select count(*) into v_exists from trasee where id_tren=v_id_tren and id_statie2=v_id2;
        if v_exists>0 then
            select nume into v_nume_tren from trenuri where id=v_id_tren;
            select ora_plecare,minut_plecare into v_ora_plec,v_min_plec from trasee where id_statie1=v_id1 and id_tren=v_id_tren;
            select ora_sosire,minut_sosire into v_ora_sos,v_min_sos from trasee where id_statie2=v_id2 and id_tren=v_id_tren;
            select to_char(sysdate, 'HH24'),to_char(sysdate, 'MI') into ora,min from dual;
            --if ora_plecare<ora or (ora_plecare=ora and v_min_plec>min) then
                v_rez:=v_rez||statie1||','||statie2||','||v_nume_tren||','||v_ora_plec||':'||v_min_plec||','||v_ora_sos||':'||v_min_sos||';';
            --end if;
        end if;
        EXIT WHEN cursor_trenuri%NOTFOUND;
    END LOOP;
    CLOSE cursor_trenuri;
    return v_rez;
END;


function statii_traseu(statie1 varchar2,statie2 varchar2, tren varchar2) 
return varchar2 as
BEGIN
    v_rez2:=statie1||',';
    select id into v_id1 from statii where nume=statie1;
    select id into v_id2 from statii where nume=statie2;
    select id into v_id_tren from trenuri where nume=tren;
    select ordine into ordine1 from trasee where id_statie1=v_id1 and id_tren=v_id_tren;
    select ordine into ordine2 from trasee where id_statie2=v_id2 and id_tren=v_id_tren;
    for v_contor in ordine1..ordine2 loop
        select id_statie2 into v_id2 from trasee where id_statie1=v_id1 and id_tren=v_id_tren;
        select nume into v_nume_statie from statii where id=v_id2;
        v_rez2:=v_rez2||v_nume_statie||',';
        v_id1:=v_id2;
    end loop;
    return v_rez2;
END;


procedure traseu_schimbare(statie1 varchar2, statie2 varchar2) as
begin
    select id into v_id1 from statii where nume=statie1;
    select id into v_id2 from statii where nume=statie2;
    open cursor_trenuri1(v_id1);
    <<trenuri1>>
    loop
    fetch cursor_trenuri1 into v_id_tren1, ordine1;
      open cursor_trenuri2(v_id2);
      <<trenuri2>>
      loop
            fetch cursor_trenuri2 into v_id_tren2, ordine2;
                if v_id_tren1!=v_id_tren2 then
                    found:=false;
                    open cursor_statii1(v_id_tren1,ordine1);
                    <<statii1>>
                    loop
                        fetch cursor_statii1 into v_id_statie1;
                        open cursor_statii2(v_id_tren2,ordine2);
                        <<statii2>>
                        loop
                            fetch cursor_statii2 into v_id_statie2;
                              if v_id_statie1=v_id_statie2 then
                                  found:=true;
                                  dbms_output.put_line(v_id_statie1||' '||v_id_statie2||' '||v_id_tren1||' '||v_id_tren2);
                                  exit statii1 when v_id_statie1=v_id_statie2;
                              end if;
                           exit when cursor_statii2%notfound;
                        end loop statii1;
                        if cursor_statii2%isopen then
                          close cursor_statii2;
                        end if;
                        exit when cursor_statii1%notfound;
                    end loop statii2;
                    if cursor_statii1%isopen then
                      close cursor_statii1;
                    end if;
                    if cursor_statii2%isopen then
                      close cursor_statii2;
                    end if;
                end if;
            exit when cursor_trenuri2%notfound;
      end loop trenuri2;
      if cursor_trenuri2%isopen then
        close cursor_trenuri2;
      end if;
    exit when cursor_trenuri1%notfound;
    end loop trenuri1;
     if cursor_trenuri1%isopen then
        close cursor_trenuri1;
      end if;
      if cursor_trenuri2%isopen then
        close cursor_trenuri2;
      end if;
end;


procedure statii_bfs(statie1 varchar2, statie2 varchar2) as
begin
    if cursor_bfs%isopen=true then
      close cursor_bfs;
      end if;
    select id into v_id1 from statii where nume=statie1;
    select id into v_id_statie2 from statii where nume=statie2;
    bfs:=varr(v_id1);
    found:=false;
    v_contor:=2;
    <<exterior>>
    while found=false loop
        open cursor_bfs(v_id1);
        found2:=false;
        <<interior>>
        loop
          fetch cursor_bfs into v_id2;
          bfs(v_contor):=v_id2;
          v_contor:=v_contor+1;
          if v_id2=v_id_statie2 then
            found:=true;
            exit exterior;
            end if;
          exit when cursor_bfs%notfound;
          if found2=false then
            found2:=true;
            v_id1:=v_id2;
          end if;
        end loop;
        close cursor_bfs;
    end loop;
    
end;

end traseu;


  

begin
dbms_output.put_line(traseu.traseu_direct('Agnita' ,'Ardud'));
--traseu.traseu_direct('Agnita' ,'Ardud');
end;

select * from trasee;
select nume from statii where id=9 or id=12;


select to_char(sysdate, 'YYYY') as year, 
       to_char(sysdate, 'MM') as month, 
       to_char(sysdate, 'DD') as day,
       to_char(sysdate, 'HH24') as hour,
       to_char(sysdate, 'MI') as minute
from dual;
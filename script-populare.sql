drop table trasee cascade constraints 
/
drop table vagoane cascade constraints
/
drop table trenuri cascade constraints
/
drop table conturi cascade constraints
/
drop table bilete cascade constraints
/
drop table statii cascade constraints
/
drop table locuri_ocupate cascade constraints
/
create table trenuri (
  id int not null primary key,
  nume varchar2(10) not null
)
/
create table statii (
  id int not null primary key,
  nume varchar(30)
)
/
create table vagoane (
  id int not null primary key,
  id_tren int not null,
  numar int,
  clasa int,
  nr_locuri int,
  constraint fk_vagoane_id_tren foreign key (id_tren) references trenuri(id)
)
/
create table trasee (
  id_statie1 int not null,
  id_statie2 int not null,
  id_tren int not null,
  ordine int not null,
  ora_plecare int,
  minut_plecare int,
  ora_sosire int,
  minut_sosire int,
  km int,
  constraint fk_trasee_id_statie1 foreign key (id_statie1) references statii(id),
  constraint fk_trasee_id_statie2 foreign key (id_statie2) references statii(id),
  constraint fk_trasee_id_tren foreign key(id_tren) references trenuri(id)
)
/
create table conturi (
  id int primary key not null,
  nume varchar2(20),
  prenume varchar2(20),
  cont varchar2(40) not null,
  parola varchar2(20)
)
/
create table bilete(
  id_utlizator int not null,
  id_tren int not null,
  id_statie1 int not null,
  id_statie2 int not null,
  id_vagon int not null,
  nr_locuri int,
  ora_plecare int,
  minut_placeare int,
  ora_sosire int,
  minut_sosire int
)
/
create table locuri_ocupate(
  id_tren int,
  id_vagon int,
  id_statie1 int, 
  id_statie2 int,
  data date,
  constraint fk_locuri_ocupate_id_statie1 foreign key (id_statie1) references statii(id),
  constraint fk_locuri_ocupate_id_statie2 foreign key (id_statie2) references statii(id),
  constraint fk_locuri_ocupate_id_tren foreign key(id_tren) references trenuri(id),
  constraint fk_locuri_ocupate_id_vagon foreign key (id_vagon) references vagoane(id)
)
/
















set serveroutput on;

declare
  type varr is varray(1000) of varchar2(255);
  lista_nume varr := varr('Ababei','Acasandrei','Adascalitei','Afanasie','Agafitei','Agape','Aioanei','Alexandrescu','Alexandru','Alexe','Alexii','Amarghioalei','Ambroci','Andonesei','Andrei','Andrian','Andrici','Andronic','Andros','Anghelina','Anita','Antochi','Antonie','Apetrei','Apostol','Arhip','Arhire','Arteni','Arvinte','Asaftei','Asofiei','Aungurenci','Avadanei','Avram','Babei','Baciu','Baetu','Balan','Balica','Banu','Barbieru','Barzu','Bazgan','Bejan','Bejenaru','Belcescu','Belciuganu','Benchea','Bilan','Birsanu','Bivol','Bizu','Boca','Bodnar','Boistean','Borcan','Bordeianu','Botezatu','Bradea','Braescu','Budaca','Bulai','Bulbuc-aioanei','Burlacu','Burloiu','Bursuc','Butacu','Bute','Buza','Calancea','Calinescu','Capusneanu','Caraiman','Carbune','Carp','Catana','Catiru','Catonoiu','Cazacu','Cazamir','Cebere','Cehan','Cernescu','Chelaru','Chelmu','Chelmus','Chibici','Chicos','Chilaboc','Chile','Chiriac','Chirila','Chistol','Chitic','Chmilevski','Cimpoesu','Ciobanu','Ciobotaru','Ciocoiu','Ciofu','Ciornei','Citea','Ciucanu','Clatinici','Clim','Cobuz','Coca','Cojocariu','Cojocaru','Condurache','Corciu','Corduneanu','Corfu','Corneanu','Corodescu','Coseru','Cosnita','Costan','Covatariu','Cozma','Cozmiuc','Craciunas','Crainiceanu','Creanga','Cretu','Cristea','Crucerescu','Cumpata','Curca','Cusmuliuc','Damian','Damoc','Daneliuc','Daniel','Danila','Darie','Dascalescu','Dascalu','Diaconu','Dima','Dimache','Dinu','Dobos','Dochitei','Dochitoiu','Dodan','Dogaru','Domnaru','Dorneanu','Dragan','Dragoman','Dragomir','Dragomirescu','Duceac','Dudau','Durnea','Edu','Eduard','Eusebiu','Fedeles','Ferestraoaru','Filibiu','Filimon','Filip','Florescu','Folvaiter','Frumosu','Frunza','Galatanu','Gavrilita','Gavriliuc','Gavrilovici','Gherase','Gherca','Ghergu','Gherman','Ghibirdic','Giosanu','Gitlan','Giurgila','Glodeanu','Goldan','Gorgan','Grama','Grigore','Grigoriu','Grosu','Grozavu','Gurau','Haba','Harabula','Hardon','Harpa','Herdes','Herscovici','Hociung','Hodoreanu','Hostiuc','Huma','Hutanu','Huzum','Iacob','Iacobuta','Iancu','Ichim','Iftimesei','Ilie','Insuratelu','Ionesei','Ionesi','Ionita','Iordache','Iordache-tiroiu','Iordan','Iosub','Iovu','Irimia','Ivascu','Jecu','Jitariuc','Jitca','Joldescu','Juravle','Larion','Lates','Latu','Lazar','Leleu','Leon','Leonte','Leuciuc','Leustean','Luca','Lucaci','Lucasi','Luncasu','Lungeanu','Lungu','Lupascu','Lupu','Macariu','Macoveschi','Maftei','Maganu','Mangalagiu','Manolache','Manole','Marcu','Marinov','Martinas','Marton','Mataca','Matcovici','Matei','Maties','Matrana','Maxim','Mazareanu','Mazilu','Mazur','Melniciuc-puica','Micu','Mihaela','Mihai','Mihaila','Mihailescu','Mihalachi','Mihalcea','Mihociu','Milut','Minea','Minghel','Minuti','Miron','Mitan','Moisa','Moniry-abyaneh','Morarescu','Morosanu','Moscu','Motrescu','Motroi','Munteanu','Murarasu','Musca','Mutescu','Nastaca','Nechita','Neghina','Negrus','Negruser','Negrutu','Nemtoc','Netedu','Nica','Nicu','Oana','Olanuta','Olarasu','Olariu','Olaru','Onu','Opariuc','Oprea','Ostafe','Otrocol','Palihovici','Pantiru','Pantiruc','Paparuz','Pascaru','Patachi','Patras','Patriche','Perciun','Perju','Petcu','Pila','Pintilie','Piriu','Platon','Plugariu','Podaru','Poenariu','Pojar','Popa','Popescu','Popovici','Poputoaia','Postolache','Predoaia','Prisecaru','Procop','Prodan','Puiu','Purice','Rachieru','Razvan','Reut','Riscanu','Riza','Robu','Roman','Romanescu','Romaniuc','Rosca','Rusu','Samson','Sandu','Sandulache','Sava','Savescu','Schifirnet','Scortanu','Scurtu','Sfarghiu','Silitra','Simiganoschi','Simion','Simionescu','Simionesei','Simon','Sitaru','Sleghel','Sofian','Soficu','Sparhat','Spiridon','Stan','Stavarache','Stefan','Stefanita','Stingaciu','Stiufliuc','Stoian','Stoica','Stoleru','Stolniceanu','Stolnicu','Strainu','Strimtu','Suhani','Tabusca','Talif','Tanasa','Teclici','Teodorescu','Tesu','Tifrea','Timofte','Tincu','Tirpescu','Toader','Tofan','Toma','Toncu','Trifan','Tudosa','Tudose','Tuduri','Tuiu','Turcu','Ulinici','Unghianu','Ungureanu','Ursache','Ursachi','Urse','Ursu','Varlan','Varteniuc','Varvaroi','Vasilache','Vasiliu','Ventaniuc','Vicol','Vidru','Vinatoru','Vlad','Voaides','Vrabie','Vulpescu','Zamosteanu','Zazuleac');
  lista_prenume varr := varr(  'Adina','Alexandra','Alina','Ana','Anca','Anda','Andra','Andreea','Andreia','Antonia','Bianca','Camelia','Claudia','Codrina','Cristina','Daniela','Daria','Delia','Denisa','Diana','Ecaterina','Elena','Eleonora','Elisa','Ema','Emanuela','Emma','Gabriela','Georgiana','Ileana','Ilona','Ioana','Iolanda','Irina','Iulia','Iuliana','Larisa','Laura','Loredana','Madalina','Malina','Manuela','Maria','Mihaela','Mirela','Monica','Oana','Paula','Petruta','Raluca','Sabina','Sanziana','Simina','Simona','Stefana','Stefania','Tamara','Teodora','Theodora','Vasilica','Xena','Adrian','Alex','Alexandru','Alin','Andreas','Andrei','Aurelian','Beniamin','Bogdan','Camil','Catalin','Cezar','Ciprian','Claudiu','Codrin','Constantin','Corneliu','Cosmin','Costel','Cristian','Damian','Dan','Daniel','Danut','Darius','Denise','Dimitrie','Dorian','Dorin','Dragos','Dumitru','Eduard','Elvis','Emil','Ervin','Eugen','Eusebiu','Fabian','Filip','Florian','Florin','Gabriel','George','Gheorghe','Giani','Giulio','Iaroslav','Ilie','Ioan','Ion','Ionel','Ionut','Iosif','Irinel','Iulian','Iustin','Laurentiu','Liviu','Lucian','Marian','Marius','Matei','Mihai','Mihail','Nicolae','Nicu','Nicusor','Octavian','Ovidiu','Paul','Petru','Petrut','Radu','Rares','Razvan','Richard','Robert','Roland','Rolland','Romanescu','Sabin','Samuel','Sebastian','Sergiu','Silviu','Stefan','Teodor','Teofil','Theodor','Tudor','Vadim','Valentin','Valeriu','Vasile','Victor','Vlad','Vladimir','Vladut');
  lista_statii varr := varr ('Abrud','Adjud','Agnita','Aiud','Alba Iulia','Ale?d','Alexandria','Amara','Anina','Aninoasa','Arad','Ardud','Avrig','Azuga','Babadag','B?beni','Bac?u','Baia de Aram?','Baia de Arie?','Baia Mare','Baia Sprie','B?icoi','B?ile Govora','B?ile Herculane','B?ile Ol?ne?ti','B?ile Tu?nad','B?ile?ti','B?lan','B?lce?ti','Bal?','Baraolt','Bârlad','Bechet','Beclean','Beiu?','Berbe?ti','Bere?ti','Bicaz','Bistri?a','Blaj','Boc?a','Bolde?ti-Sc?eni','Bolintin-Vale','Bor?a','Borsec','Boto?ani','Brad','Bragadiru','Br?ila','Bra?ov','Breaza','Brezoi','Bro?teni','Bucecea','Bucure?ti','Bude?ti','Buftea','Buhu?i','Bumbe?ti-Jiu','Bu?teni','Buz?u','Buzia?','Cajvana','Calafat','C?lan','C?l?ra?i','C?lim?ne?ti','Câmpeni','Câmpia Turzii','Câmpina','Câmpulung Moldovenesc','Câmpulung','Caracal','Caransebe?','Carei','Cavnic','C?z?ne?ti','Cehu Silvaniei','Cernavod?','Chi?ineu-Cri?','Chitila','Ciacova','Cisn?die','Cluj-Napoca','Codlea','Com?ne?ti','Comarnic','Constan?a','Cop?a Mic?','Corabia','Coste?ti','Covasna','Craiova','Cristuru Secuiesc','Cugir','Curtea de Arge?','Curtici','D?buleni','Darabani','D?rm?ne?ti','Dej','Deta','Deva','Dolhasca','Dorohoi','Dr?g?ne?ti-Olt','Dr?g??ani','Dragomire?ti','Drobeta-Turnu Severin','Dumbr?veni','Eforie','F?g?ra?','F?get','F?lticeni','F?urei','Fete?ti','Fieni','Fierbin?i-Târg','Filia?i','Fl?mânzi','Foc?ani','Frasin','Fundulea','G?e?ti','Gala?i','G?taia','Geoagiu','Gheorgheni','Gherla','Ghimbav','Giurgiu','Gura Humorului','Hârl?u','Hâr?ova','Ha?eg','Horezu','Huedin','Hunedoara','Hu?i','Ianca','Ia?i','Iernut','Ineu','Însur??ei','Întorsura Buz?ului','Isaccea','Jibou','Jimbolia','Lehliu Gar?','Lipova','Liteni','Livada','Ludu?','Lugoj','Lupeni','M?cin','M?gurele','Mangalia','M?r??e?ti','Marghita','Medgidia','Media?','Miercurea Ciuc','Miercurea Nirajului','Miercurea Sibiului','Mih?ile?ti','Mili??u?i','Mioveni','Mizil','Moine?ti','Moldova Nou?','Moreni','Motru','Murfatlar','Murgeni','N?dlac','N?s?ud','N?vodari','Negre?ti','Negre?ti-Oa?','Negru Vod?','Nehoiu','Novaci','Nucet','Ocna Mure?','Ocna Sibiului','Ocnele Mari','Odobe?ti','Odorheiu Secuiesc','Olteni?a','One?ti','Oradea','Or??tie','Oravi?a','Or?ova','O?elu Ro?u','Otopeni','Ovidiu','Panciu','Pâncota','Pantelimon','Pa?cani','P?târlagele','Pecica','Petrila','Petro?ani','Piatra Neam?','Piatra-Olt','Pite?ti','Ploie?ti','Plopeni','Podu Iloaiei','Pogoanele','Pope?ti-Leordeni','Potcoava','Predeal','Pucioasa','R?cari','R?d?u?i','Râmnicu S?rat','Râmnicu Vâlcea','Râ?nov','Reca?','Reghin','Re?i?a','Roman','Ro?iorii de Vede','Rovinari','Roznov','Rupea','S?cele','S?cueni','Salcea','S?li?te','S?li?tea de Sus','Salonta','Sângeorgiu de P?dure','Sângeorz-B?i','Sânnicolau Mare','Sântana','S?rma?u','Satu Mare','S?veni','Scornice?ti','Sebe?','Sebi?','Segarcea','Seini','Sfântu Gheorghe','Sibiu','Sighetu Marma?iei','Sighi?oara','Simeria','?imleu Silvaniei','Sinaia','Siret','Sl?nic','Sl?nic-Moldova','Slatina','Slobozia','Solca','?omcuta Mare','Sovata','?tef?ne?ti', 'Arge?','?tef?ne?ti', 'Boto?ani','?tei','Strehaia','Suceava','Sulina','T?lmaciu','??nd?rei','Târgovi?te','Târgu Bujor','Târgu C?rbune?ti','Târgu Frumos','Târgu Jiu','Târgu L?pu?','Târgu Mure?','Târgu Neam?','Târgu Ocna','Târgu Secuiesc','Târn?veni','T??nad','T?u?ii-M?gher?u?','Techirghiol','Tecuci','Teiu?','?icleni','Timi?oara','Tismana','Titu','Topli?a','Topoloveni','Tulcea','Turceni','Turda','Turnu M?gurele','Ulmeni','Ungheni','Uricani','Urla?i','Urziceni','Valea lui Mihai','V?lenii de Munte','Vânju Mare','Va?c?u','Vaslui','Vatra Dornei','Vicovu de Sus','Victoria','Videle','Vi?eu de Sus','Vl?hi?a','Voluntari','Vulcan','Zal?u','Z?rne?ti','Zimnicea','Zlatna');
  lista_tipuri varr := varr('R', 'IR','IRN');
  v_id integer;
  v_id1 integer;
  v_id2 integer;
  v_id_tren integer;
  v_ordine integer;
  v_ora_sos integer;
  v_min_sos integer;
  v_ora_plec integer;
  v_min_plec integer;
  v_km integer;
  v_nume varchar2(100);
  v_prenume varchar2(100);
  v_parola number;
  v_nume_tren varchar2(100);
  v_contor integer;
  v_exists integer;
  v_exists2 integer;
  v_cont varchar2(100);
  v_tip varchar2(5);
  v_trenuri integer;
  v_statie1 varchar2(100);
  v_statie2 varchar2(100);
  
  BEGIN
  
  --conturi
  FOR v_id IN 1..1000 LOOP
      v_nume := lista_nume(TRUNC(DBMS_RANDOM.VALUE(0,lista_nume.count))+1);    
      v_prenume := lista_prenume(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume.count))+1);          
      v_cont:=lower(v_nume)||'.'||lower(v_prenume);
      select count(*) into v_exists from conturi where cont=v_cont;
      while v_exists>0 loop
          v_nume := lista_nume(TRUNC(DBMS_RANDOM.VALUE(0,lista_nume.count))+1);    
          v_prenume := lista_prenume(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume.count))+1);          
          v_cont:=lower(v_nume)||'.'||lower(v_prenume);
          select count(*) into v_exists from conturi where cont=v_cont;
      end loop;
      v_parola := TRUNC(DBMS_RANDOM.VALUE(1000,100000));
      insert into conturi values(v_id, v_nume, v_prenume ,v_cont, v_parola);
   END LOOP;
  
  
  --statii
  FOR v_id IN 1..lista_statii.count LOOP
    v_nume:=lista_statii(v_id);
    insert into statii values(v_id,v_nume);
    END LOOP;
  
  --trenuri
  for v_id IN 1..1000 LOOP
      v_tip:=lista_tipuri(TRUNC(DBMS_RANDOM.VALUE(0,lista_tipuri.count))+1);
      v_contor:=TRUNC(DBMS_RANDOM.VALUE(1000,10000));
      v_nume_tren:=v_tip||v_contor;
      select count(*) into v_exists from trenuri where nume=v_nume_tren;
      while(v_exists>0) loop
        v_contor:=TRUNC(DBMS_RANDOM.VALUE(1000,10000));
        v_nume_tren:=v_tip||v_contor;
        select count(*) into v_exists from trenuri where nume=v_nume_tren;
      end loop;
      insert into trenuri values(v_id,v_nume_tren);
  end loop;

  --trasee
  for v_id_tren in 1..10 loop
      --v_statie1:=lista_statii(TRUNC(DBMS_RANDOM.VALUE(1,lista_statii.count)));
      v_statie1:=lista_statii(TRUNC(DBMS_RANDOM.VALUE(1,20)));
      select id into v_id1 from statii where nume=v_statie1;
      select dbms_random.value(0,23) into v_ora_plec from dual;
      select dbms_random.value(0,59) into v_min_plec from dual;
      for v_ordine in 1..5 loop
          --v_statie2:=lista_statii(TRUNC(DBMS_RANDOM.VALUE(1,lista_statii.count)));
          v_statie2:=lista_statii(TRUNC(DBMS_RANDOM.VALUE(1,20)));
          select id into v_id2 from statii where nume=v_statie2;
          select count(*) into v_exists from trasee where id_tren=v_id_tren and id_statie1=v_id1 and id_statie2=v_id2;
          select count(*) into v_exists2 from trasee where id_tren=v_id_tren and id_statie1=v_id2 and id_statie2=v_id1;
          while v_exists>0 or v_exists2>0 or v_id1=v_id2 loop
               --v_statie2:=lista_statii(TRUNC(DBMS_RANDOM.VALUE(1,lista_statii.count)));
               v_statie2:=lista_statii(TRUNC(DBMS_RANDOM.VALUE(1,20)));
              select id into v_id2 from statii where nume=v_statie2;
              select count(*) into v_exists from trasee where id_tren=v_id_tren and id_statie1=v_id1 and id_statie2=v_id2;
              select count(*) into v_exists2 from trasee where id_tren=v_id_tren and id_statie1=v_id2 and id_statie2=v_id1;
          end loop;
          if v_ora_plec=23 then
              v_ora_sos:=0;
            else
              v_ora_sos:=v_ora_plec+1;
            end if;
            select dbms_random.value(0,59) into v_min_sos from dual;
            select count(*) into v_exists from trasee where id_statie1=v_id1 and id_statie2=v_id2;
            if v_exists>0 then
                select km into v_km from trasee where id_statie1=v_id1 and id_statie2=v_id2;
            else
                select dbms_random.value(50,500) into v_km from dual;
              end if;
            insert into trasee values(v_id1,v_id2,v_id_tren,v_ordine,v_ora_plec,v_min_plec,v_ora_sos,v_min_sos,v_km);
            v_id1:=v_id2;
            v_ora_plec:=v_ora_sos;
            select dbms_random.value(v_min_sos,59) into v_min_plec from dual;
      end loop;
  end loop;
  
  END;
  
  --3--12--1 Agnita Ardud IRN8050
  select nume from trenuri where id=1;
  
  select * from trasee;
  
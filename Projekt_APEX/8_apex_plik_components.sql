set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.0.00.45'
,p_default_workspace_id=>5204078181319734
,p_default_application_id=>103
,p_default_owner=>'BIURO'
);
end;
/
prompt --application/set_environment
 
prompt APPLICATION 103 - Biuro Turystyczne
--
-- Application Export:
--   Application:     103
--   Name:            Biuro Turystyczne
--   Date and Time:   21:11 Thursday January 12, 2017
--   Exported By:     BIURO
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     LOV: STANDARD
--     LOV: ADRES
--     LOV: WYCIECZKA
--     LOV: FAKTURA
--     LOV: PRZEWODNIK
--     LOV: PRACOWNIK
--     LOV: KLIENT
--     LOV: RABAT
--     LOV: CZY WYZYWIENIE
--     LOV: CZY STUDENT
--     LOV: MUZEUM
--     LOV: ATRAKCJA
--     LOV: HOTEL
--     LOV: RESTAURACJA
--     LOV: AUTOKAR
--     LOV: KRAJ
--     LOV: LINIE LOTNICZE
--     LOV: MIASTO
--     LOV: OFERTA
--     LOV: TYP WYCIECZKI
--     LOV: UBEZPIECZYCIEL
--   Manifest End
--   Version:         5.1.0.00.45
--   Instance ID:     211614163038354
--

-- C O M P O N E N T    E X P O R T
begin
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/user_interface/lovs/6625896592276887
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(6625896592276887)
,p_lov_name=>'STANDARD'
,p_lov_query=>'.'||wwv_flow_api.id(6625896592276887)||'.'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(6626106313276890)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'1'
,p_lov_return_value=>'1'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(6626534962276891)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'2'
,p_lov_return_value=>'2'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(6626909677276891)
,p_lov_disp_sequence=>3
,p_lov_disp_value=>'3'
,p_lov_return_value=>'3'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(6627319865276891)
,p_lov_disp_sequence=>4
,p_lov_disp_value=>'4'
,p_lov_return_value=>'4'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(6627701329276892)
,p_lov_disp_sequence=>5
,p_lov_disp_value=>'5'
,p_lov_return_value=>'5'
);
end;
/
prompt --application/shared_components/user_interface/lovs/12655370953525367
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(12655370953525367)
,p_lov_name=>'ADRES'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select miasto || '', '' || kod_pocztowy || '', '' || ulica || '' '' || nr_domu as d,',
'       id_adres as r',
'  from adres',
' order by 1'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/12653478795431402
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(12653478795431402)
,p_lov_name=>'WYCIECZKA'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id_wycieczka || '', termin: '' || data_wyjazdu || ''-'' || data_powrotu || '', cena: '' || cena_od_os as d,',
'       id_wycieczka as r',
'  from wycieczka',
' order by 1'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/12653709484458637
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(12653709484458637)
,p_lov_name=>'FAKTURA'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id_faktura || '', data: '' || data || '', cena: '' || cena_brutto as d,',
'       id_faktura as r',
'  from faktura',
' order by 1'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/12650598417288426
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(12650598417288426)
,p_lov_name=>'PRZEWODNIK'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nazwisko || '', '' ||imie as d,',
'       id_przewodnik as r',
'  from przewodnik',
' order by 1'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/12653939716466078
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(12653939716466078)
,p_lov_name=>'PRACOWNIK'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nazwisko || '', '' || imie as d,',
'       id_pracownik as r',
'  from pracownik',
' order by 1'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/12654086836496596
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(12654086836496596)
,p_lov_name=>'KLIENT'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select NAZWISKO || '', '' || IMIE as display_value, ID_KLIENT as return_value ',
'  from KLIENT',
' order by 1'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/6561641353154283
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(6561641353154283)
,p_lov_name=>'RABAT'
,p_lov_query=>'.'||wwv_flow_api.id(6561641353154283)||'.'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(6561936722154284)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'TAK'
,p_lov_return_value=>'TAK'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(6562394820154284)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'NIE'
,p_lov_return_value=>'NIE'
);
end;
/
prompt --application/shared_components/user_interface/lovs/6560681562151160
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(6560681562151160)
,p_lov_name=>'CZY WYZYWIENIE'
,p_lov_query=>'.'||wwv_flow_api.id(6560681562151160)||'.'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(6560978337151161)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'TAK'
,p_lov_return_value=>'TAK'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(6561367075151161)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'NIE'
,p_lov_return_value=>'NIE'
);
end;
/
prompt --application/shared_components/user_interface/lovs/6559681738146821
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(6559681738146821)
,p_lov_name=>'CZY STUDENT'
,p_lov_query=>'.'||wwv_flow_api.id(6559681738146821)||'.'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(6559913256146822)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'TAK'
,p_lov_return_value=>'TAK'
);
wwv_flow_api.create_static_lov_data(
 p_id=>wwv_flow_api.id(6560335069146826)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'NIE'
,p_lov_return_value=>'NIE'
);
end;
/
prompt --application/shared_components/user_interface/lovs/6559591951143674
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(6559591951143674)
,p_lov_name=>'MUZEUM'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nazwa as d,',
'       id_muzeum as r',
'  from muzeum',
' order by 1'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/6559370934140280
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(6559370934140280)
,p_lov_name=>'ATRAKCJA'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nazwa as d,',
'       id_atrakcja as r',
'  from atrakcja',
' order by 1'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/6559165795136520
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(6559165795136520)
,p_lov_name=>'HOTEL'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nazwa as d,',
'       id_hotel as r',
'  from hotel',
' order by 1'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/6558929597131462
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(6558929597131462)
,p_lov_name=>'RESTAURACJA'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nazwa as d,',
'       id_restauracja as r',
'  from restauracja',
' order by 1'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/12650188092204326
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(12650188092204326)
,p_lov_name=>'AUTOKAR'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nazwa_przewoznika as d,',
'       id_autokar as r',
'  from autokar',
' order by 1'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/12652333915353725
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(12652333915353725)
,p_lov_name=>'KRAJ'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nazwa as d,',
'       id_kraj as r',
'  from kraj',
' order by 1'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/12649852655183544
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(12649852655183544)
,p_lov_name=>'LINIE LOTNICZE'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nazwa_linii as d,',
'       id_linie_lotnicze as r',
'  from linie_lotnicze',
' order by 1'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/12652692679377172
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(12652692679377172)
,p_lov_name=>'MIASTO'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nazwa as d,',
'       id_miasto as r',
'  from miasto',
' order by 1'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/12650410133211634
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(12650410133211634)
,p_lov_name=>'OFERTA'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nazwa as d,',
'       id_oferta as r',
'  from oferta',
' order by 1'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/12651911513336310
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(12651911513336310)
,p_lov_name=>'TYP WYCIECZKI'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nazwa as d,',
'       id_typ_wycieczki as r',
'  from typ_wycieczki',
' order by 1'))
);
end;
/
prompt --application/shared_components/user_interface/lovs/12649304152061767
begin
wwv_flow_api.create_list_of_values(
 p_id=>wwv_flow_api.id(12649304152061767)
,p_lov_name=>'UBEZPIECZYCIEL'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nazwa as d,',
'       id_ubezpieczyciel as r',
'  from ubezpieczyciel',
' order by 1'))
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done

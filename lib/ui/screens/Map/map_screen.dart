import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:registrovot/ui/screens/getdata/consultarLideres_screen.dart';

import '../../common/staticsFields.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final _mapController = MapController();
  StaticFields staticfields = StaticFields();

  final PopupController _popupController = PopupController();

  final List<Map<String, dynamic>> locations = [
    {
      "municipio": "Valledupar",
      "nombre": "I.e. Joaquin Ochoa Maestre",
      "direccion": "Cll 59 No 25 - 95 Barrio Mareigua",
      "latitud": "10.436143",
      "longitud": "-73.2537740000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "ESTABL PENITENC DE ALTA Y MEDIANA SEGURIDAD",
      "direccion": "Via Correg. La Mesa",
      "latitud": "10.447213",
      "longitud": "-73.3076259999999"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Los Haticos",
      "direccion": "Esc. Nueva Los Haticos",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Los Haticos",
      "direccion": "Esc. Nueva Los Haticos",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Col. Santo Domingo",
      "direccion": "Cll 19 B No 4 G 03 Barrio Santo Domi",
      "latitud": "10.46881999999999",
      "longitud": "-73.2470050000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "I.e. Loperena Garupal",
      "direccion": "Tr 23 No 21 - 27 Barrio Garupal",
      "latitud": "10.4699103",
      "longitud": "-73.2696947000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "El Jabo",
      "direccion": "Esc. Rural Mixta El Jabo",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Sabana Crespo",
      "direccion": "CENTRO EDUC. ETNO GUN ARUWAN",
      "latitud": "10.57940209999999",
      "longitud": "-73.4160732999998"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Inst. Tec. Enrique Pupo",
      "direccion": "Cll 29 No 26 - 37 Barrio Enrique Pupo",
      "latitud": "10.45138200000000",
      "longitud": "-73.2572260000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Ins.tec.pedro Castro Monsalvo",
      "direccion": "Cr 19 No 11-60",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "La Mina",
      "direccion": "Esc. Basica Primaria El Centro",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Universidad De Santander  - UDES",
      "direccion": "Cr 6 No 14 - 27",
      "latitud": "10.478721",
      "longitud": "-73.2454850000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "I.e. Consuelo Araujo Noguera",
      "direccion": "Cr 38 Cll 20 Ciudadela 450 AÑos",
      "latitud": "10.44400000000000",
      "longitud": "-73.2740000000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Caracoli",
      "direccion": "Inst. Luis Rodriguez Valera",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Patillal",
      "direccion": "Col. Educacion Media De Patillal",
      "latitud": "10.70236079999999",
      "longitud": "-73.2203547999998"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Conc. Milciades Cantillo",
      "direccion": "Cll 44 No 23 - 51 Barrio Villa Fuentes",
      "latitud": "10.445694",
      "longitud": "-73.2506389999998"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Conc. San Joaquin",
      "direccion": "Cll 9 A No 13-44",
      "latitud": "10.4823951",
      "longitud": "-73.2592333999999"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Guaimaral",
      "direccion": "Esc. Rural Mixta Guimaral",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Col. Nacional Loperena",
      "direccion": "Cll 16 No 11 - 75 Barrio Centro",
      "latitud": "10.47349400000000",
      "longitud": "-73.2489800000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "I. E. SAN ISIDRO LABRADOR - ATANQUEZ",
      "direccion": "ATANQUEZ-SALIDA CHEMESQUEMENAGUATAPUR",
      "latitud": "10.70040333",
      "longitud": "-73.3561406900000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Azucar Buena",
      "direccion": "Cent Educativo La Virgen Del Carmen",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "I.e. Leonidas Acuna",
      "direccion": "Cr 12 No 30 - 483 Barrio 12 De Octubre",
      "latitud": "10.454013",
      "longitud": "73.2421009999999"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Col. Comfacesar",
      "direccion": "Cll 1a No 38-49 Av Sierra Nevada",
      "latitud": "10.48600000000000",
      "longitud": "-73.2800000000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Guacoche",
      "direccion": "Inst. Jose Celestino Mutis",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Col. Jose Eugenio Martinez",
      "direccion": "Cll 18 B No 30 A 54 Barrio Casimiro",
      "latitud": "10.453467",
      "longitud": "-73.2670159999999"
    },
    {
      "municipio": "Valledupar",
      "nombre": "El Alto De La Vuelta",
      "direccion": "Esc. Nueva Del Alto De La Vuelta",
      "latitud": "10.58796899999999",
      "longitud": "-73.1426409999999"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Los Venados",
      "direccion": "I.e. Luis Rodriguez Valera Seccion P",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Col. Francisco Molina Sanchez",
      "direccion": "Cr 4 Cll 30 A Barrio Los Mayales",
      "latitud": "10.460169",
      "longitud": "-73.2290059999999"
    },
    {
      "municipio": "Valledupar",
      "nombre": "I.e. Tec. La Esperanza",
      "direccion": "Cll 6 No 37-100",
      "latitud": "10.46993649999999",
      "longitud": "-73.2762608000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "El Perro",
      "direccion": "Luis Rodriguez Valera Sede 4",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Valencia De Jesus",
      "direccion": "I.e. Luis Ovidio Rincon Lobo",
      "latitud": "10.30090599999999",
      "longitud": "-73.3959739999999"
    },
    {
      "municipio": "Valledupar",
      "nombre": "I.e. Rafael Valle Meza",
      "direccion": "Cll 26 No 19 - 30 Barrio 1° De Mayo",
      "latitud": "10.457096",
      "longitud": "-73.2514259999998"
    },
    {
      "municipio": "Valledupar",
      "nombre": "I.e. Rafael Valle Meza 12 de Octubre",
      "direccion": "CLL 30 No 14-87 B. 12 DE OCTUBRE",
      "latitud": "10.45700000000000",
      "longitud": "-73.2510000000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Carcel Judicial",
      "direccion": "Cr 19 No 18-60",
      "latitud": "10.464216",
      "longitud": "-73.2560950000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Los Corazones",
      "direccion": "Esc. Nueva Los Corazones",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Col. Prudencia Daza",
      "direccion": "Cll 19 B No 12 - 80 Barrio Gaitan",
      "latitud": "10.4796320",
      "longitud": "-73.2454640"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Col. Nacionalizado Alfonso Lopez",
      "direccion": "Cll 13 B Bis No 19 - 120",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Chemesquemena",
      "direccion": "Coop. Guacheme Salon Comunitario",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Rioseco",
      "direccion": "Esc. Nueva De San Fernando",
      "latitud": "10.59610540000000",
      "longitud": "-73.2324813999998"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Conc. Alfonso Araujo Cotes",
      "direccion": "Cr 22 No 35 - 50",
      "latitud": "10.44941900000000",
      "longitud": "-73.2510690000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Col. La Sagrada Familia",
      "direccion": "Tr 8 No 2 B 85",
      "latitud": "10.493",
      "longitud": "-73.2639999999998"
    },
    {
      "municipio": "Valledupar",
      "nombre": "La Vega Arriba",
      "direccion": "Esc. Rural Nueva La Vega Arriba",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Esc. De Bellas Artes",
      "direccion": "Cll 15 No 12 A 54",
      "latitud": "10.474216",
      "longitud": "-73.2512590000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Escuela Mixta No 4",
      "direccion": "Cll 16 B No 19 B 14",
      "latitud": "10.46654900000000",
      "longitud": "-73.2584180000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Badillo",
      "direccion": "I.e. Antonio Enrique Diaz Martinez",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Mariangola",
      "direccion": "Inst. Rodolfo Castro Castro",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Universidad Abierta Y A Distancia - UNAD",
      "direccion": "Cll 39 No 4 B 02",
      "latitud": "10.45173",
      "longitud": "-73.23677"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Col. Pablo Sexto",
      "direccion": "Cll 13 A No 6-88",
      "latitud": "10.48",
      "longitud": "-73.247"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Guatapuri",
      "direccion": "Inst. Prom. Soc. Guatapuri",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Col. Nacionalizado Upar",
      "direccion": "Dg 19 No 23-14 Barrio Fundadores",
      "latitud": "10.4589264",
      "longitud": "-73.2622847"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Aguas Blancas",
      "direccion": "Esc. Mixta No 12",
      "latitud": "10.22770399999999",
      "longitud": "-73.4898919999998"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Las Raices",
      "direccion": "Esc. Nueva Las Raices",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "I.e. Manuel German Cuello",
      "direccion": "Cll 23 A No 4 D 15 Barrio Santa Rita",
      "latitud": "10.4632559",
      "longitud": "-73.236005"
    },
    {
      "municipio": "Valledupar",
      "nombre": "I.e. Bello Horizonte",
      "direccion": "Cll 5h No 49-06 Cll Ppal Bello Horiznte",
      "latitud": "10.478",
      "longitud": "-73.2870000000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Guacochito",
      "direccion": "Esc. Rural Mixta De Guacochito",
      "latitud": "",
      "longitud": ""
    },
    {
      "municipio": "Valledupar",
      "nombre": "Villa Germania",
      "direccion": "Kiosco Comunal Villa Germania",
      "latitud": "10.266743",
      "longitud": "-73.7137199999998"
    },
    {
      "municipio": "Valledupar",
      "nombre": "Hogar del Nino",
      "direccion": "TRANS. 5A No 25A-193",
      "latitud": "10.4600973",
      "longitud": "-73.2391193"
    },
    {
      "municipio": "Valledupar",
      "nombre": "MEGA COLEGIO RICARDO GONZALEZ",
      "direccion": "CRA 47 DIAGONAL 10-105",
      "latitud": "10.486001",
      "longitud": "-73.2804550000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "CENTRO EDUCATIVO DE SISTEMAS UPARSISTEM",
      "direccion": "CALLE 16 A No 12 36 BARRIO LOPERENA",
      "latitud": "10.472570",
      "longitud": "-73.249762"
    },
    {
      "municipio": "Valledupar",
      "nombre": "COL PARROQUIAL EL CARMELO",
      "direccion": "CLL 20A No 5C-49",
      "latitud": "10.469464",
      "longitud": "-73.2379809999999"
    },
    {
      "municipio": "Valledupar",
      "nombre": "ESCUELA SAN FERNANDO",
      "direccion": "CALLE 46 No 4 B - 10",
      "latitud": "10.4462922",
      "longitud": "-73.2383887000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "SENA C. ECONOMIA NARANJA REGIONAL CESAR",
      "direccion": "CALLE 39 No 5 170 BARRIO PANAMA",
      "latitud": "10.451889",
      "longitud": "-73.231998"
    },
    {
      "municipio": "Valledupar",
      "nombre": "IE NELSON MANDELA",
      "direccion": "CLL 63 No 31A-32",
      "latitud": "10.435",
      "longitud": "-73.262"
    },
    {
      "municipio": "Valledupar",
      "nombre": "IE OSWALDO QUINTANA QUINTANA",
      "direccion": "CRA 27 No 78A-14 LORENZO MORALES",
      "latitud": "10.46190400000000",
      "longitud": "-73.2667145000000"
    },
    {
      "municipio": "Valledupar",
      "nombre": "IE MAYOR V/DUPAR CESAR POMPEYO MENDOZA",
      "direccion": "CALLE 18 D CARRERA 34 D BARRIO FRANCISCO DE PAULA",
      "latitud": "10.449038",
      "longitud": "-73.270920"
    },
    {
      "municipio": "Valledupar",
      "nombre": "UNIV. POPULAR DEL CESAR(SEDE SABANAS)",
      "direccion": "DIAG. 21 No 29-56 SABANAS DEL VALLE",
      "latitud": "10.5005322",
      "longitud": "-73.269915"
    },
    {
      "municipio": "Valledupar",
      "nombre": "INST. TEC. VILLA CORELCA",
      "direccion": "DG 16 B No 24 BIS 52",
      "latitud": "10.46148299999999",
      "longitud": "-73.2674989999999"
    },
    {
      "municipio": "Valledupar",
      "nombre": "COLISEO CUBIERTO JULIO MONSALVO CASTILLA",
      "direccion": "CALLE 11 No 19 C 05 AVENIDA JUVENTUD",
      "latitud": "10.474797",
      "longitud": "-73.262713"
    },
    {
      "municipio": "Valledupar",
      "nombre": "IE EDUARDO SUAREZ ORCASITA",
      "direccion": "CLL 12 NO 25-47 GARUPAL",
      "latitud": "10.47961699999999",
      "longitud": "-73.2775869999998"
    },
    {
      "municipio": "Valledupar",
      "nombre": "FUNDACION UNIVERSITARIA DEL AREA ANDINA",
      "direccion": "TRANSVERSAL 22 BIS No 4 105 BARRIO CALLEJAS",
      "latitud": "10.48289",
      "longitud": "-73.27176600000001"
    },
    {
      "municipio": "Valledupar",
      "nombre": "COLEGIO COLOMBO INGLES",
      "direccion": "CALLE 11 No 17 - 66 BARRIO SAN JOAQUIN",
      "latitud": "10.476276",
      "longitud": "-73.258623"
    },
    {
      "municipio": "Valledupar",
      "nombre": "ESCUELA NUEVA RAMALITO",
      "direccion": "VEREDA RAMALITO CORREGIMIENTO ATANQUEZ",
      "latitud": "10.698540",
      "longitud": "-73.314964"
    },
    {
      "municipio": "Valledupar",
      "nombre": "ESCUELA TEZHUMKE",
      "direccion": "RESGUARDO INDIGENA TEZHUMKE",
      "latitud": "10.731056",
      "longitud": "-73.258265"
    }
  ];
  final List<Map<String, dynamic>> locationscartag = [
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "CENTRO COMERCIAL BOCAGRANDE",
      "direccion": "CR 2 NO 8-146 BOCAGRANDE AV SAN MARTIN",
      "latitud": "10.40436390638633",
      "longitud": "-75.5538636445999"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "UNIV. TECNOLG. DE BOLIVAR - MANGA",
      "direccion": "CLL DEL BOUQUET CR 21 NO. 25-92 MANGA",
      "latitud": "10.41315751288616",
      "longitud": "-75.5382160371619"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "LUDOTECA PARQUE CENTENARIO",
      "direccion": "GETSEMANI, CLL 32 No 7-120, PQ CENTENARIO",
      "latitud": "10.42230252063896",
      "longitud": "-75.5472064018248"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "COL. EUCARÍSTICO DE SANTA TERESA",
      "direccion": "Manga, Calle 27 No. 24-21",
      "latitud": "10.41402714404831",
      "longitud": "-75.5363863706588"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "CENTRO COMERCIAL PLAZA BOCAGRANDE",
      "direccion": "CRA 1 No 12 - 118",
      "latitud": "10.41117900000000",
      "longitud": "-75.5557926999999"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "COLEGIO DE LA ESPERANZA",
      "direccion": "CLL 63 NO 02-04 CRESPO",
      "latitud": "10.44396202000000",
      "longitud": "-75.5238982500000"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "COLEGIO NAVAL DE CRESPO",
      "direccion": "AV 9A CLL 72 BARRIO MILITAR CRESPO",
      "latitud": "10.45030906",
      "longitud": "-75.5139366199998"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "COLEGIO EL CARMELO",
      "direccion": "CLL 66 NO 4-73 CRESPO",
      "latitud": "10.44643645",
      "longitud": "-75.5207429799999"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "COLEGIO BERVELLY HILLS",
      "direccion": "CRESPO CRA 2 No 77-71",
      "latitud": "10.44417040435454",
      "longitud": "-75.5213338136671"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "COLEGIO LICEO BOLIVAR",
      "direccion": "CR 17 NO 71-25 DANIEL LEMAITRE",
      "latitud": "10.43785018",
      "longitud": "-75.5182516600000"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "IE STA MARIA SEDE SAGRADO CORAZON",
      "direccion": "CR 16 No 67-50 DANIEL LEMAITRE",
      "latitud": "10.43774531",
      "longitud": "-75.5171121700000"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "I.E.CORAZON DE MARIA",
      "direccion": "SAN FRANCISCO FRENTE AL CAI CRA 19 No 77-29",
      "latitud": "10.43492421",
      "longitud": "-75.5156354399998"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "IE CORAZON DE MARIA S S J CLAVER",
      "direccion": "SAN FRANCISCO CRA 19 No 77-30",
      "latitud": "10.43450926",
      "longitud": "-75.5157775800000"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "I.E. SANTA MARIA",
      "direccion": "Lemaitre Cra 17 Nro 70 B -119",
      "latitud": "10.43821953780602",
      "longitud": "-75.5172836780547"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "COLISEO CUBIERTO BERNARDO CARABALLO",
      "direccion": "CRA 17 No 35-119",
      "latitud": "10.577886269614199",
      "longitud": "-75.46549055544025"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "COLEGIO JOSE DE LA VEGA",
      "direccion": "CLL 54 NO 17 - 102 TORICES",
      "latitud": "10.43514908999999",
      "longitud": "-75.5281532799998"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "IE HER. ANTONIO RAMOS DE LA SALLE",
      "direccion": "CLL NUEVA DEL ESPINAL NO 34-392 ESPINAL",
      "latitud": "10.42416343999999",
      "longitud": "-75.5358254899998"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "INST. ED. ANA MARIA VELEZ DE TRUJILLO",
      "direccion": "TORICES, SECTOR SANTA RITA CRA 16 # 17-53",
      "latitud": "10.43508579103233",
      "longitud": "-75.5280822515486"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "C.ECON. PIEDRA DE BOL UNIV. C/GENA",
      "direccion": "AV CONSULADO CLL 30 NO 48-152 PIEDRA DE BOLIVAR",
      "latitud": "10.40265293",
      "longitud": "-75.5058222999999"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "COLEGIO COMFENALCO SEDE CEDESARROLLO",
      "direccion": "DG 30 No 50-187 ZARAGOCILLA SECTOR EL CAIRO",
      "latitud": "10.40512592",
      "longitud": "-75.5035093200000"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "INST. ED. MADRE LAURA",
      "direccion": "PIEDRA BOLIVAR CLL 30 NRO. 50 - 136",
      "latitud": "10.4046488218533",
      "longitud": "-75.5079442262648"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "SENA 4 VIENTOS",
      "direccion": "AV. PEDRO DE HEREDIA SECTOR TESCA",
      "latitud": "10.4063160997406",
      "longitud": "-75.5033254623412"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "IE CASD MANUELA BELTRAN",
      "direccion": "AV PEDRO DE HEREDIA CLL 31 No 57-106",
      "latitud": "10.40077160000000",
      "longitud": "-75.4944828"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "IE NUEVO BOSQUE",
      "direccion": "TR 53 NO 23A-104 MZ I URB BARLOVENTO",
      "latitud": "10.39128242",
      "longitud": "-75.5008280299998"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "COL ALBERTO ELIAS FERNANDEZ",
      "direccion": "DG 21A 47-49 AV BUENOS AIRES BOSQUE",
      "latitud": "10.39785747",
      "longitud": "-75.5201670099999"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "I.E NUEVO BOSQUE SEDE JOSE MARIA CORDOBA",
      "direccion": "NUEVO BOSQUE 1RA ETAPA TRANSV 47A NRO 29E - 12",
      "latitud": "10.391",
      "longitud": "-75.5"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "INST. ED. FERNANDO DE LA VEGA",
      "direccion": "BOSQUE DIAG. 21C NRO 53-40",
      "latitud": "10.3894991364793",
      "longitud": "-75.5223651230334"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "ESCUELA NORMAL SUPERIOR DE CARTAGENA De INDIAS",
      "direccion": "NUEVO BOSQUE KRA 51 #23-35",
      "latitud": "10.39103590340056",
      "longitud": "-75.5095723271368"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "UNIVERSIDAD DEL SINU SEDE PLAZA COLON",
      "direccion": "AV EL BOSQUE TRANSVERSAL 54 No 30 729",
      "latitud": "10.39002",
      "longitud": "-75.49653"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "IE SAN JUAN DE DAMASCO",
      "direccion": "AMBERES 1ER CALLEJON CR 41 NO 26C 38",
      "latitud": "10.40532269999999",
      "longitud": "-75.5140030400000"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "IE OLGA GONZALEZ ARRAUT",
      "direccion": "DG 22 NO 52-14 AV CRISANTO LUQUE",
      "latitud": "10.39135667999999",
      "longitud": "-75.5165453999998"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "IE MANUELA BELTRAN - SEDE HIJOS",
      "direccion": "BARRIO CHILE MZ 75 LOTE 1",
      "latitud": "10.39273247",
      "longitud": "-75.5133176399998"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "SEMINARIO CARTAGENA",
      "direccion": "ALCIBIA CLL 38 NRO 29 - 60",
      "latitud": "10.40830521391846",
      "longitud": "-75.5163314938544"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "UNIVERSIDAD ANTONIO NARIÑO",
      "direccion": "AV CRISANTO LUQUE DIAG 22",
      "latitud": "10.395",
      "longitud": "-75.5169999999998"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "COLEGIO LATINOAMERICANO",
      "direccion": "B. PARAGUAY TRANS 45 No 26A 116 AV DEL ACUEDUCTO",
      "latitud": "10.39971",
      "longitud": "-75.51454"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "UNIV DE CARTAGENA CLAUSTRO SAN AGUSTIN",
      "direccion": "CR 6 36-100 CTRO CLL DE LA UNIVERSIDAD",
      "latitud": "10.42551017000000",
      "longitud": "-75.5500561199999"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "COL SALESIANOS SAN PEDRO CLAVER",
      "direccion": "CLL 40 NO 09-80 LAS BOVEDAS BARRIO SAN DIEGO",
      "latitud": "10.42935552",
      "longitud": "-75.5463830900000"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "IE ANTONIA SANTOS",
      "direccion": "CLL 31 NO 18B 131 PLAYON GRANDE PIE DE LA POPA",
      "latitud": "10.42127224",
      "longitud": "-75.5358469500000"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "UNIV. DE CARTAGENA CLAUSTRO LA MERCED",
      "direccion": "KR 5 # 38-40 - CENTRO",
      "latitud": "10.42702917792472",
      "longitud": "-75.5511253171492"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "FUNDACION UNIVERSITARIA LOS LIBERTADORES",
      "direccion": "PIE DE LA POPA, CALLE 31 No 19 -51",
      "latitud": "10.42132383757628",
      "longitud": "-75.5344256758689"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "INST UNIVERSITARIA MAYOR DE CARTAGENA",
      "direccion": "CENTRO KR 3 #34 -29 CL DE LA FACTORIA",
      "latitud": "10.42609734579576",
      "longitud": "-75.5519900806076"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "INST UNI BELLAS ARTES Y CIENCIAS DE BOLIVAR",
      "direccion": "KR 9 #39-12 SAN DIEGO",
      "latitud": "10.42811716717295",
      "longitud": "-75.5472698847600"
    },
    {
      "municipio": "Distrito de Cartagena de Indias",
      "nombre": "ESCUELAS PROFESIONALES SALESIANAS",
      "direccion": "Cra 9 # 39-60 CALLE DE LAS BOVEDAS CENTRO",
      "latitud": "10.42843810385103",
      "longitud": "-75.5472401198471"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: mainController.emailUser.contains('@edil.com')
              ? const LatLng(10.39972, -75.51444)
              : const LatLng(10.463445, -73.246214),
          zoom: 13.6,
        ),
        nonRotatedChildren: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () {
                        final centerZoom = _mapController
                            .centerZoomFitBounds(_mapController.bounds!);
                        var zoom = centerZoom.zoom + 0.5;
                        if (zoom > 20) {
                          zoom = 20;
                        }
                        _mapController.move(centerZoom.center, zoom);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton(
                      child: const Icon(Icons.remove),
                      onPressed: () {
                        final centerZoom = _mapController
                            .centerZoomFitBounds(_mapController.bounds!);
                        var zoom = centerZoom.zoom - 0.5;
                        if (zoom < 10) {
                          zoom = 10;
                        }
                        _mapController.move(centerZoom.center, zoom);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          )
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
              markers: mainController.emailUser.contains('@edil.com')
                  ? locationscartag.map((locationscartag) {
                      final lat =
                          double.tryParse(locationscartag["latitud"]) ?? 0;
                      final lon =
                          double.tryParse(locationscartag["longitud"]) ?? 0;
                      return Marker(
                        point: LatLng(lat, lon),
                        builder: (context) => customMarker(locationscartag),
                      );
                    }).toList()
                  : locations.map((location) {
                      final lat = double.tryParse(location["latitud"]) ?? 0;
                      final lon = double.tryParse(location["longitud"]) ?? 0;
                      return Marker(
                        point: LatLng(lat, lon),
                        builder: (context) => customMarker(location),
                      );
                    }).toList()),
          // PolylineLayer(
          //   polylines: [
          //     Polyline(
          //       points: [
          //         // Comuna 1
          //         LatLng(10.466640, -73.298122),
          //         LatLng(10.463514, -73.256205),
          //         LatLng(10.459033, -73.232257),
          //         LatLng(10.447430, -73.232257),
          //         LatLng(10.443279, -73.256205),
          //         LatLng(10.440485, -73.298122),
          //       ],
          //       color: Colors.red,
          //       strokeWidth: 5,
          //     ),
          //     Polyline(
          //       points: [
          //         // Comuna 2
          //         LatLng(10.463445, -73.246214),
          //         LatLng(10.47961699999999, -73.2775869999998),
          //       ],
          //       color: Colors.blue,
          //       strokeWidth: 5,
          //     ),
          //     Polyline(
          //       points: [
          //         // Comuna 3
          //         LatLng(10.47961699999999, -73.2775869999998),
          //         LatLng(10.486651, -73.265886),
          //       ],
          //       color: Colors.orange,
          //       strokeWidth: 5,
          //     ),
          //     Polyline(
          //       points: [
          //         // Comuna 4
          //         LatLng(10.486651, -73.265886),
          //         LatLng(10.493542, -73.254481),
          //       ],
          //       color: Colors.green,
          //       strokeWidth: 5,
          //     ),
          //     Polyline(
          //       points: [
          //         // Comuna 5
          //         LatLng(10.493542, -73.254481),
          //         LatLng(10.496972, -73.247034),
          //       ],
          //       color: Colors.purple,
          //       strokeWidth: 5,
          //     ),
          //     Polyline(
          //       points: [
          //         // Comuna 6
          //         LatLng(10.496972, -73.247034),
          //         LatLng(10.499883, -73.239591),
          //       ],
          //       color: Colors.pink,
          //       strokeWidth: 5,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  customMarker(Map<String, dynamic> location) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(location['nombre']),
              content: Text(location['direccion']),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.location_on,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

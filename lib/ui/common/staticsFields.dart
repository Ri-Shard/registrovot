import 'dart:math';

class StaticFields {
  List<Municipio> getMunicipios() {
    var listamunicipios = [
      {
        "departamento": "Cesar",
        "nombre": "Valledupar",
        "latitud": "10.4776626",
        "longitud": "-73.2439139",
        "ubicacion": "Norte",
      },
      {
        "departamento": "Cesar",
        "nombre": "Agustin Codazzi",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Norte",
      },
      {
        "departamento": "Cesar",
        "nombre": "La Paz",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Norte",
      },
      {
        "departamento": "Cesar",
        "nombre": "Manaure",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Norte",
      },
      {
        "departamento": "Cesar",
        "nombre": "San Diego",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Norte",
      },
      {
        "departamento": "Cesar",
        "nombre": "Pueblo Bello",
        "latitud": "",
        "longitud": "",
        "ubicacion": "NorOccidente",
      },
      {
        "departamento": "Cesar",
        "nombre": "Curumaní",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Sur",
      },
      {
        "departamento": "Cesar",
        "nombre": "La Jagua de Ibirico",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Norte",
      },
      {
        "departamento": "Cesar",
        "nombre": "Chiriguaná",
        "latitud": "",
        "longitud": "",
        "ubicacion": "NorOccidente",
      },
      {
        "departamento": "Cesar",
        "nombre": "Pailitas",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Sur",
      },
      {
        "departamento": "Cesar",
        "nombre": "Chimichagua",
        "latitud": "",
        "longitud": "",
        "ubicacion": "NorOccidente",
      },
      {
        "departamento": "Cesar",
        "nombre": "Becerril",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Norte",
      },
      {
        "departamento": "Cesar",
        "nombre": "Tamalameque",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Sur",
      },
      {
        "departamento": "Cesar",
        "nombre": "Bosconia",
        "latitud": "",
        "longitud": "",
        "ubicacion": "NorOccidente",
      },
      {
        "departamento": "Cesar",
        "nombre": "El Copey",
        "latitud": "",
        "longitud": "",
        "ubicacion": "NorOccidente",
      },
      {
        "departamento": "Cesar",
        "nombre": "Astrea",
        "latitud": "",
        "longitud": "",
        "ubicacion": "NorOccidente",
      },
      {
        "departamento": "Cesar",
        "nombre": "El Paso",
        "latitud": "",
        "longitud": "",
        "ubicacion": "NorOccidente",
      },
      {
        "departamento": "Cesar",
        "nombre": "Aguachica",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Sur",
      },
      {
        "departamento": "Cesar",
        "nombre": "San Alberto",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Sur",
      },
      {
        "departamento": "Cesar",
        "nombre": "Pelaya",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Sur",
      },
      {
        "departamento": "Cesar",
        "nombre": "Gamarra",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Sur",
      },
      {
        "departamento": "Cesar",
        "nombre": "San Martín",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Sur",
      },
      {
        "departamento": "Cesar",
        "nombre": "La Gloria",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Sur",
      },
      {
        "departamento": "Cesar",
        "nombre": "Rio de Oro",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Sur",
      },
      {
        "departamento": "Cesar",
        "nombre": "González",
        "latitud": "",
        "longitud": "",
        "ubicacion": "Sur",
      }
    ];
    List<Municipio> response = [];
    for (var element in listamunicipios) {
      response.add(Municipio.fromJson(element));
    }
    return response;
  }

  List<Barrio> getBarrios() {
    var listaBarrios = [
      {"municipio": "Valledupar", "barrio": "El Centro", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "Loperena", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "AltaGracia", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "La Garita", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "El Cerezo", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "El Carmen", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "Gaitan", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "Kennedy", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "La Granja", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "San Jorge", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "Sicarare", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "Santo Domingo", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "San Antonio", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "Las Palmas", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "Pablo VI", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "Guatapurí", "comuna": "1"},
      {
        "municipio": "Valledupar",
        "barrio": "Santa Ana (Hernando de Santana)",
        "comuna": "1"
      },
      {"municipio": "Valledupar", "barrio": "Las Delicias", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "Hospital", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "Pescaito", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "9 de Marzo", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "San Vicente", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "Alfonso Lopez", "comuna": "1"},
      {"municipio": "Valledupar", "barrio": "Villa Castro", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "Urb. Doña Clara", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "Urb. Montecarlo", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "Versalles", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "Candelaria Sur", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "Villa del Rosario", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "Villa Clara", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "Santa Rita", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "5 de Noviembre", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "Santa Rosa", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "12 de Octubre", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "Los Mayales", "comuna": "2"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Los Mayales Etapa 1",
        "comuna": "2"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Los Mayales Etapa 2",
        "comuna": "2"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Los Mayales Etapa 3",
        "comuna": "2"
      },
      {"municipio": "Valledupar", "barrio": "Los Cocos", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "Panamá", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "Panamá Etapa 2", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "Los Milagros", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "San Fernando", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "San Jorge", "comuna": "2"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Galán Sarmiento",
        "comuna": "2"
      },
      {"municipio": "Valledupar", "barrio": "Urb. Maria Elena", "comuna": "2"},
      {"municipio": "Valledupar", "barrio": "Urb. Casa Campo", "comuna": "2"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Bosques de Rancho Mio",
        "comuna": "2"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Amaneceres del Valle",
        "comuna": "2"
      },
      {"municipio": "Valledupar", "barrio": "Primero de Mayo", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "San Martin", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "Villa Leonor", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "Valle Meza", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "7 de Agosto", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "Urb. Los Alamos 1", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "Villa Olga", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "San Francisco", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "El Prado", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "Rueda", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "La Manuelita", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "La Felicidad", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "Villa Fuentes", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "El Oasis", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "Don Carmelo", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "Mareigua", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "Tierra Prometida", "comuna": "3"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. El Rincon de Ziruma",
        "comuna": "3"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Altos de Ziruma",
        "comuna": "3"
      },
      {"municipio": "Valledupar", "barrio": "25 de Diciembre", "comuna": "3"},
      {
        "municipio": "Valledupar",
        "barrio": "OGB - Conjunto Residencial Oscar Guerra Bonilla",
        "comuna": "3"
      },
      {"municipio": "Valledupar", "barrio": "La Terminal", "comuna": "3"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Mayales Aeropuerto",
        "comuna": "3"
      },
      {"municipio": "Valledupar", "barrio": "Urb. La 27", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "Nuevo Milenio", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "El Paramo", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "La Primavera", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "Villa Jaidith", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "Chiriquí", "comuna": "3"},
      {"municipio": "Valledupar", "barrio": "Urb. Nando Marin", "comuna": "3"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Lorenzo Morales",
        "comuna": "3"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Parques de Bolivar - Leandro Diaz Etapa 1",
        "comuna": "3"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Parques de Bolivar - Leandro Diaz Etapa 2",
        "comuna": "3"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Parques de Bolivar - Leandro Diaz Etapa 3",
        "comuna": "3"
      },
      {"municipio": "Valledupar", "barrio": "Los Caciques", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Los Fundadores", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Sabanas del Valle", "comuna": "4"},
      {
        "municipio": "Valledupar",
        "barrio": "Casimiro Raul Maestre",
        "comuna": "4"
      },
      {"municipio": "Valledupar", "barrio": "Manatial", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Edgardo Pupo", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Villa Corelca", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "El Cerrito", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Urb. Alamos 2", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Urb. Alamos 3", "comuna": "4"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Maria Camila Sur",
        "comuna": "4"
      },
      {"municipio": "Valledupar", "barrio": "Villa Miriam", "comuna": "4"},
      {
        "municipio": "Valledupar",
        "barrio": "Francisco de Paula Santander",
        "comuna": "4"
      },
      {"municipio": "Valledupar", "barrio": "Villa Luz", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Villa Arcadia", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "El Hogar", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Villa Taxi", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "La Victoria", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "El Progreso", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "ciceron Maestre", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Buena Vista", "comuna": "4"},
      {
        "municipio": "Valledupar",
        "barrio": "Jose Antonio Galán",
        "comuna": "4"
      },
      {"municipio": "Valledupar", "barrio": "Villa Algenia", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Limonar", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Villa Maruamake", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Urb. La Floresta", "comuna": "4"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Valle Hermoso",
        "comuna": "4"
      },
      {"municipio": "Valledupar", "barrio": "San Marino", "comuna": "4"},
      {
        "municipio": "Valledupar",
        "barrio": "Ciudadela 450 Años",
        "comuna": "4"
      },
      {"municipio": "Valledupar", "barrio": "Villa Dariana", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "8 de Diciembre", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Villa Magdala", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Urb. Lindaraja", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Las Acacias", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "El Rocio", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Geirzin", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Populandia", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Urb. Tobias Daza", "comuna": "4"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Rafael Escalona",
        "comuna": "4"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Ciudadela Comfacesar",
        "comuna": "4"
      },
      {"municipio": "Valledupar", "barrio": "San Jeronimo", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Las Cabañas", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Girasoles", "comuna": "4"},
      {"municipio": "Valledupar", "barrio": "Villalba", "comuna": "5"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Altos del Villalba",
        "comuna": "5"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Altos del Rosario",
        "comuna": "5"
      },
      {"municipio": "Valledupar", "barrio": "Urb. Maria Raiza", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Enrique Pupo", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Pedro Martinez", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Dundakare", "comuna": "5"},
      {
        "municipio": "Valledupar",
        "barrio": "Pedro Nel Martinez",
        "comuna": "5"
      },
      {"municipio": "Valledupar", "barrio": "Arizona", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "San Isidro", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Villa Carel", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Los Cortijos", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Azucar Buena", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Garupal", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "El Eneal", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Iracal", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "El Amparo", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Ichagua", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "La Esperanza", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Urb. Villa Monica", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Candelaria Norte", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Nueva Esperanza", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Villa Concha", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Villa Fanny", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Concepcion Perez", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "20 de Julio", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "5 de Enero", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Divino Niño", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Urb. La Ceiba", "comuna": "5"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. La Ceiba de AltaGracia",
        "comuna": "5"
      },
      {"municipio": "Valledupar", "barrio": "Urb. AltaGracia", "comuna": "5"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Francisco el Hombre",
        "comuna": "5"
      },
      {"municipio": "Valledupar", "barrio": "La Nevada", "comuna": "5"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Ciudad Tayrona",
        "comuna": "5"
      },
      {"municipio": "Valledupar", "barrio": "Urb. Don Alberto", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Urb. El Refugio", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Bello Horizonte", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Villa Janeth", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "San Isidro", "comuna": "5"},
      {
        "municipio": "Valledupar",
        "barrio": "Orientes de Calleja",
        "comuna": "5"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Conjunto Cerrado Los Rosales",
        "comuna": "5"
      },
      {"municipio": "Valledupar", "barrio": "Urb. Santo Tomas", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Nuevo Amanecer", "comuna": "5"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Maria Camila Norte",
        "comuna": "5"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Rosario Norte",
        "comuna": "5"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Portal del Rosario",
        "comuna": "5"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Urb. La Castellana",
        "comuna": "5"
      },
      {"municipio": "Valledupar", "barrio": "Villa Ligia 1", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Villa Ligia 2", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Villa Ligia 3", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Villa Ligia 4", "comuna": "5"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Altos del Rosario",
        "comuna": "5"
      },
      {"municipio": "Valledupar", "barrio": "Urb. Los Corales", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "San Pedro", "comuna": "5"},
      {
        "municipio": "Valledupar",
        "barrio": "Conjunto Cerrado San Pedro",
        "comuna": "5"
      },
      {"municipio": "Valledupar", "barrio": "Las Cabañas", "comuna": "5"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Quintas del Rosario",
        "comuna": "5"
      },
      {"municipio": "Valledupar", "barrio": "Urb. Don Lucas", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "La Castellana", "comuna": "5"},
      {
        "municipio": "Valledupar",
        "barrio": "Mirador de la Sierra 3",
        "comuna": "5"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Mirador de la Sierra 4",
        "comuna": "5"
      },
      {"municipio": "Valledupar", "barrio": "Comfacesar", "comuna": "5"},
      {"municipio": "Valledupar", "barrio": "Las Marias", "comuna": "5"},
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Quintas del Country",
        "comuna": "5"
      },
      {"municipio": "Valledupar", "barrio": "Club House", "comuna": "5"},
      {
        "municipio": "Valledupar",
        "barrio": "Boulevar del Rosario",
        "comuna": "5"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Urb. Rocas del Valle",
        "comuna": "5"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Conjunto Residencial del Norte",
        "comuna": "6"
      },
      {
        "municipio": "Valledupar",
        "barrio": "Conjunto Residencial Los Campanos",
        "comuna": "6"
      },
      {"municipio": "Valledupar", "barrio": "Urb. Rosalia", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "Pasadena", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "Los Angeles", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "Serranilla", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "Aremasin", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "Ciudad Jardin", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "Ponteveedra", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "San Carlos", "comuna": "6"},
      {
        "municipio": "Valledupar",
        "barrio": "Villa del Rosario Norte",
        "comuna": "6"
      },
      {"municipio": "Valledupar", "barrio": "Cañaguate", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "San Clemente", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "Novalito", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "Chimila", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "Alfonso Lopez", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "Obrero", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "Villa Clara", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "San Joaquin", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "La Guajira", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "San Vicente", "comuna": "6"},
      {"municipio": "Valledupar", "barrio": "Urb. Santa Rosalia", "comuna": "6"}
    ];

    List<Barrio> response = [];
    for (var element in listaBarrios) {
      response.add(Barrio.fromJson(element));
    }
    return response;
  }
}

class Barrio {
  String? municipio;
  String? barrio;
  String? comuna;

  Barrio({this.municipio, this.barrio, this.comuna});

  Barrio.fromJson(Map<String, dynamic> json) {
    municipio = json['municipio'];
    barrio = json['barrio'];
    comuna = json['comuna'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['municipio'] = municipio;
    data['barrio'] = barrio;
    data['comuna'] = comuna;
    return data;
  }
}

class Municipio {
  String? departamento;
  String? nombre;
  String? latitud;
  String? longitud;
  String? ubicacion;

  Municipio(
      {this.departamento,
      this.nombre,
      this.latitud,
      this.longitud,
      this.ubicacion});

  Municipio.fromJson(Map<String, dynamic> json) {
    departamento = json['departamento'];
    nombre = json['nombre'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    ubicacion = json['ubicacion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['departamento'] = departamento;
    data['nombre'] = nombre;
    data['latitud'] = latitud;
    data['longitud'] = longitud;
    data['ubicacion'] = ubicacion;
    return data;
  }
}

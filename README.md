# Stub de conversión de monedas de Forex Crypto Stock

Este proyecto es un stub que simula la obtención de tasas de conversión entre dos monedas utilizando la api de [Forex Crypto Stock](https://fcsapi.com/) 


El fichero `assets/exchangeRates.json` contiene las tasas de conversión obtenidas el 25/10/2023 de todas las combinaciones posibles de las siguientes monedas:

- EUR: euro
- USD: dólar USA
- JPY: yen japonés
- DKK: corona danesa
- GBP: libra esterlina
- SEK: corona sueca
- CHF: franco suizo
- NOK: corona noruega
- RUB: rublo ruso
- TRY: lira turca
- AUD: dólar australiano
- BRL: real brasileño
- CAD: dólar canadiense
- CNY: yuan chino
- INR: rupia india
- MXN: peso mexicano
- ZAR: rand sudafricano

## Uso 


El stub dispone de un único método `get` que simula una llamada al servidor de FCS. 
Este método toma exactamente los mismos parámetros que una petición http de tipo get al servidor FCS y devuelve una respuesta análoga. 

**Importante**: el stub no simula errores de conexión con el servidor.

El fichero `main.dart` contiene un ejemplo de uso del stub:

```
import 'dart:convert';

import 'server_stub.dart' as stub;

void main() async {
  var uri = Uri(
      scheme: 'https',
      host: 'fcsapi.com',
      path: "/api-v3/forex/latest",
      queryParameters: {
        'symbol': "EUR/USD,EUR/JPY,EUR/GBP",
        'access_key': 'MY_API_KEY',
      });
  var response = await stub.get(uri);
  print(response.statusCode);
  print(response.body);
  var dataAsDartMap = jsonDecode(response.body);
  print(dataAsDartMap);
}
```

El conjunto de conversiones solicitadas se indica separado por comas en el parámetro `symbol` 
dentro de los parámetros de la url (consultar [documentación de la api](https://fcsapi.com/document/forex-api)). Cada solicitud de conversión entre dos monedas tiene el siguiente formato `XXX/YYY`, donde `XXX` representa
el símbolo de la moneda origen e `YYY`, el símbolo de la moneda destino.

El stub devuelve las tasas de conversión con el mismo formato que la api. Si no existe tasa de 
conversión entre un par de monedas, no se incluye en el listado y se devuelven las restantes
tasas de conversión. Tampoco se devuelve tasa de conversión si las monedas origen y destino coinciden. Si no se encuentra ninguna de las tasas de conversión solicitadas, se devuelve un error.


## Sustitución del stub por el servidor FCS
Si queremos sustituir el stub por el servidor real, sólo tenemos que:

1. Incluir la librería `http` en el proyecto dart o flutter

  ```
  $ dart pub add http # para un proyecto dart
  ```
    
  ```
  $ flutter pub add http # para un proyecto flutter
  ```

2. Importar la librería `http` en el fichero
  ```
  import 'package:http/http.dart' as http;
  ```

3. Incluir la clave de acceso a la API en los parámetros de la query. Esta clave se obtiene tras registrarse en el [servidor FCS
](https://fcsapi.com/login):
  ```
  var uri = Uri(
      scheme: 'https',
      host: 'fcsapi.com',
      path: "/api-v3/forex/latest",
      queryParameters: {
        'symbol': "EUR/USD,EUR/JPY,EUR/GBP",
        'access_key': 'XaGEWT3SDGA3Cste4Eb',
      });
  ```
4. Sustituir la función `get` del stub por la función `get` de la librería http:
  ```
  var response = await http.get(uri);
  
  ```




## Uso en un proyecto flutter

1. Copiar el directorio `assets` al directorio raíz del proyecto flutter
2. Editar el fichero `pubspec.yaml` y añadir las siguiente línea en el apartado `assets` (puede que sea necesario descomentar el apartado `assets`) dejando un margen de **tres** espacios en blanco:

```
assets:
   - assets/exchangeRates.json
```
3. Copiar el fichero `server_stub.dart` al directorio `lib` del proyecto
4. Descomentar las líneas

```
import 'package:flutter/services.dart' show rootBundle; 
```
```
var stringData = await rootBundle.loadString('assets/exchangeRates.json'); 
```
5. Comentar las líneas
```
// var file = File("assets/exchangeRates.json"); // COMMENT IN FLUTTER PROJECT
// var stringData = await file.readAsString();   // COMENNT IN FLUTTER PROJECT
```
6. Importar el módulo en el fichero o ficheros donde lo deseemos utilizar

```
import 'server_stub.dart' as stub;

```

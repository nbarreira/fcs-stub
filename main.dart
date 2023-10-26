
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

import 'package:http/http.dart' as http;
import 'package:fastfeed/Constants/constants.dart';
import 'dart:convert';

 dynamic callFunction(String functionName, Map<String, dynamic> parameters) async {
    try {
    final dynamic response = await http.post(firebaseBaseUrl + functionName, headers: {"Content-Type": "application/json"}, body: json.encode({ "data": parameters }));
    return json.decode(response.body)["data"];
    } catch (e) {
      print('caught generic exception');
      print(e);
      return "Generic error";
    }
}
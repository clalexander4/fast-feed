import 'package:cloud_functions/cloud_functions.dart';

 dynamic callFunction(String functionName, Map<String, dynamic> parameters) async {
    try {
    final dynamic response = await CloudFunctions.instance.call(functionName: functionName, parameters: parameters);
    return response;
    } on CloudFunctionsException catch (e) {
      print('caught firebase functions exception');
      print(e.code);
      print(e.message);
      print(e.details);
      return "Firebase error";
    } catch (e) {
      print('caught generic exception');
      print(e);
      return "Generic error";
    }
}
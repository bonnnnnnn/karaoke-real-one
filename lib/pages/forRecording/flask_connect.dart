import 'dart:convert';
import 'package:http/http.dart' as http;

class flask_connect {
  upload (path) async {
    var myuri = "https://bonnaruma.trueddns.com";
    var request = http.MultipartRequest('POST', Uri.parse(myuri+"/upload"));
    var header = {"Authorization": "multipart/form-data"};
    request.headers.addAll(header);
    request.files.add(await http.MultipartFile.fromPath('sound', path.toString()));
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseData = await json.decode(responsed.body);
    String message = responseData['message'];
  }
}
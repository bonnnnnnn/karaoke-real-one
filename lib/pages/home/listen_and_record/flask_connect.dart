import 'dart:convert';
import 'package:http/http.dart' as http;

class flask_connect {
  upload (path, String index, String userName, String songname) async {
    var myuri = "http://192.168.1.38:4000";
    var request = http.MultipartRequest('POST', Uri.parse(myuri+"/upload?index="+index+
                                                          "&songname="+songname+
                                                          "&userName="+userName));
    var header = {"Authorization": "multipart/form-data"};
    request.headers.addAll(header);
    request.files.add(await http.MultipartFile.fromPath('sound', path.toString()));
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseData = await json.decode(responsed.body);
    String message = responseData['message'];
  }
}
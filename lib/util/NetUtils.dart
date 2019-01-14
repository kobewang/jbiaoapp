import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
class NetUtils {
  static Future<dynamic> post(String url,dynamic params) async { 
    print('post:$params');
    http.Response res = await http.post(url, body: json.encode(params),headers: {'Content-type': 'application/json'});      
      if (res.statusCode != 200) {        
        throw Exception('Failed to load post***');
      } else {
        var retBody = res.body;   
        print(retBody);
        return retBody;
      }    
  }
}
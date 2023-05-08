import 'package:http/http.dart';

class ApiManager {
 static Future<Response> getRequest(var url ,{dynamic headers}) async {
    return await get(
      Uri.parse(url),
      headers: headers,
    );
  }

  static Future<Response> putRequest(var body, var url,{dynamic headers}) async {
    return await put(
      Uri.parse(url),
      body: body,
      headers:headers
    );
  }

 static Future<Response> postRequest(var body, var url,{dynamic headers}) async {
    return await post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
  }
}

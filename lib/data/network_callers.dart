import 'dart:convert';
import 'package:http/http.dart';
import 'package:task_manager_with_get_x/controllers/authentication_controller.dart';
import 'package:task_manager_with_get_x/data/network_respone.dart';

class NetworkCallers {
  static Future<NetworkResponse> postRequestAPI(
      String urls, Map<String, dynamic> body) async {
    Response response = await post(Uri.parse(urls), body: jsonEncode(body), headers: {'content-type' : 'application/json', 'token' : AuthenticationController.accessToken});
    if(response.statusCode == 200) {
      return NetworkResponse(statusCode: response.statusCode, isSuccess: true, responseData: jsonDecode(response.body));
    } else {
      return NetworkResponse(statusCode: response.statusCode, isSuccess: false, errorMessage: "Something went Wrong" );
    }
  }

  static Future<NetworkResponse> getRequestAPI (String url ) async {
    Response response = await get(Uri.parse(url), headers: {'content-type' : 'application/json', 'token' : AuthenticationController.accessToken});
    if(response.statusCode == 200 || response.statusCode == 201) {
      return NetworkResponse(statusCode: response.statusCode, isSuccess: true, responseData: jsonDecode(response.body));
    } else {
      return NetworkResponse(statusCode: response.statusCode, isSuccess: false, responseData: null);
    }

  }
}

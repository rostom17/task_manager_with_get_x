import 'package:get/get.dart';
import 'package:task_manager_with_get_x/data/network_callers.dart';
import 'package:task_manager_with_get_x/data/network_respone.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class SignUpController extends GetxController {
  bool signUpInProgress = false;
  bool showPassword = false;

  Future<bool> signUpRequest (String email, String firstName, String lastName, String phoneNumber, String password, ) async {
    Map<String, dynamic> signUpData = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": phoneNumber,
      "password": password,
      "photo": ""
    };
    
    signUpInProgress = true;
    update();
    
    NetworkResponse networkResponse = await NetworkCallers.postRequestAPI(AssetPathsAndUrls.signUpURL, signUpData);

    signUpInProgress = false;
    update();

    if(networkResponse.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  void onPressedShowPasswordIcon () {
    showPassword = !showPassword;
    update();
  }
}
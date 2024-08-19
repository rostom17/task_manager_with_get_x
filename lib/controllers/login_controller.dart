import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/authentication_controller.dart';
import 'package:task_manager_with_get_x/data/models/login_model.dart';
import 'package:task_manager_with_get_x/data/network_callers.dart';
import 'package:task_manager_with_get_x/data/network_respone.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class LoginController extends GetxController {
  bool loginInProgress = false;
  bool passwordVisible = false;

  Future<bool> signInRequest(String email, String password) async {
    loginInProgress = true;
    update();

    Map<String, String> loginData = {"email": email, "password": password};

    final NetworkResponse networkResponse = await NetworkCallers.postRequestAPI(AssetPathsAndUrls.loginURL, loginData);

    loginInProgress = false;
    update();

    if(networkResponse.isSuccess){
      LoginModel loginModel = LoginModel.fromJson(networkResponse.responseData);
      await AuthenticationController.saveAccessToken(loginModel.token!);
      await AuthenticationController.saveUserData(loginModel.userDataModel!);
      return true;
    }
    else {
      return false ;
    }
  }

  void onPressedShowPasswordIcon () {
    passwordVisible = ! passwordVisible;
    update();
  }
}

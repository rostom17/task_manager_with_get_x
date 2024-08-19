import 'package:get/get.dart';
import 'package:task_manager_with_get_x/data/network_callers.dart';
import 'package:task_manager_with_get_x/data/network_respone.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class ForgotPasswordController extends GetxController {
  String mainEmail = '';
  String mainOTP = '';
  bool emailVerificationInProgress = false;
  bool pinVerificationInProgress = false;
  bool setPasswordInProgress = false;

  Future<bool> getEmailVerificationRequest (String email) async {
    mainEmail = email;
    emailVerificationInProgress = true;
    update();

    NetworkResponse networkResponse = await NetworkCallers.getRequestAPI(AssetPathsAndUrls.recoveryEmailURL+email);

    emailVerificationInProgress = false;
    update();

    if(networkResponse.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> verifyPinRequest (String otp) async {
    mainOTP = otp;
    pinVerificationInProgress = true;
    update();

    NetworkResponse networkResponse = await NetworkCallers.getRequestAPI("${AssetPathsAndUrls.recoveryOTPURL}$mainEmail/$otp");

    pinVerificationInProgress = false;
    update();

    if(networkResponse.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
  
  Future<bool> setPassword (String password) async {
    Map<String, dynamic> resetPassBodyData = {
      "email": mainEmail,
      "OTP": mainOTP,
      "password": password
    };

    setPasswordInProgress = true;
    update();
    
    NetworkResponse networkResponse = await NetworkCallers.postRequestAPI(AssetPathsAndUrls.resetPasswordURL, resetPassBodyData);

    setPasswordInProgress = false;
    update();

    if(networkResponse.isSuccess) {
      return true;
    } else {
      return false;
    }
    
  }
}
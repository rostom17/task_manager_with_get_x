import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/authentication_controller.dart';
import 'package:task_manager_with_get_x/data/models/user_data_model.dart';
import 'package:task_manager_with_get_x/data/network_callers.dart';
import 'package:task_manager_with_get_x/data/network_respone.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class UpdateProfileController extends GetxController {
  bool updateInProgress = false;

  Future<bool> updateProfileRequest(
      Map<String, dynamic> requestBodyData) async {
    updateInProgress = true;
    update();

    NetworkResponse networkResponse = await NetworkCallers.postRequestAPI(
        AssetPathsAndUrls.updateProfile, requestBodyData);

    if (networkResponse.isSuccess) {
      UserDataModel userDataModel = UserDataModel(
        email: requestBodyData['email'],
        firstName: requestBodyData['firstName'],
        lastName: requestBodyData['lastName'],
        mobile: requestBodyData['mobile'],
        photo: requestBodyData['photo'],
      );
      await AuthenticationController.saveUserData(userDataModel);

      updateInProgress = false;
      update();

      return true;
    } else {
      return false;
    }
  }
}

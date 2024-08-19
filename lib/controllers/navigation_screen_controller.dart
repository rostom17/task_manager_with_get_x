import 'package:get/get.dart';
import 'package:task_manager_with_get_x/data/models/user_data_model.dart';

class NavigationScreenController extends GetxController {
  int currentIndex = 0;
  void renderScreen (int value) {
    currentIndex = value;
    update();
  }

  Rx<UserDataModel> newUserData = UserDataModel().obs;
  void onChange () {

  }

}
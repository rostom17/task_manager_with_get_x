import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/authentication_controller.dart';
import 'package:task_manager_with_get_x/data/available_status.dart';

class DropDownMenuItemController  {
  Rx<AvailableStatus> currentStatus = AvailableStatus.New.obs;

  Rx<AvailableStatus> get getStatus => currentStatus;

  RxString firstName = AuthenticationController.userData!.firstName.toString().obs ;
  RxString lastName = AuthenticationController.userData!.lastName.toString().obs ;
  Rx myImage = AuthenticationController.userData!.photo.obs;


  void setData () {
    firstName = AuthenticationController.userData!.firstName.toString().obs ;
    lastName = AuthenticationController.userData!.lastName.toString().obs ;
    myImage = AuthenticationController.userData!.photo.obs;
  }

  RxString get getFirstName => firstName;
  RxString get getLastName => lastName;
  Rx get getImage => myImage;


}
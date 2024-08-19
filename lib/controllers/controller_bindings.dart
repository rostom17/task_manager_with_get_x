import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/add_new_task_controller.dart';
import 'package:task_manager_with_get_x/controllers/all_tasks_controller.dart';
import 'package:task_manager_with_get_x/controllers/delete_task_controller.dart';
import 'package:task_manager_with_get_x/controllers/forgot_password_controller.dart';
import 'package:task_manager_with_get_x/controllers/new_task_controller.dart';
import 'package:task_manager_with_get_x/controllers/cancelled_task_controller.dart';
import 'package:task_manager_with_get_x/controllers/completed_task_controller.dart';
import 'package:task_manager_with_get_x/controllers/in_progress_task_controller.dart';
import 'package:task_manager_with_get_x/controllers/login_controller.dart';
import 'package:task_manager_with_get_x/controllers/navigation_screen_controller.dart';
import 'package:task_manager_with_get_x/controllers/sign_up_controller.dart';
import 'package:task_manager_with_get_x/controllers/task_status_count_controller.dart';
import 'package:task_manager_with_get_x/controllers/update_profile_controller.dart';
import 'package:task_manager_with_get_x/controllers/update_task_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(SignUpController());
    Get.put(NavigationScreenController());
    Get.put(NewTaskController());
    Get.put(CreateTaskController());
    Get.put(CompletedTaskController());
    Get.put(CancelledTaskController());
    Get.put(InProgressTaskController());
    Get.put(AllTasksController());
    Get.put(TaskStatusCountController());
    Get.put(DeleteTaskController());
    Get.put(UpdateTaskController());
    Get.put(UpdateProfileController());
    Get.put(ForgotPasswordController());

  }
}
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/data/models/task_status_data_model.dart';
import 'package:task_manager_with_get_x/data/models/task_status_model.dart';
import 'package:task_manager_with_get_x/data/network_callers.dart';
import 'package:task_manager_with_get_x/data/network_respone.dart';

class NewTaskController extends GetxController {
  bool getNewTaskInProgress = false;

  Future<List<TaskStatusDataModel>> getNewTask (String url) async {
    getNewTaskInProgress = true;
    update();
    NetworkResponse networkResponse = await NetworkCallers.getRequestAPI(url);

    getNewTaskInProgress = false ;
    update();
    if(networkResponse.isSuccess) {
      TaskStatusModel taskStatusModel = TaskStatusModel.fromJson(networkResponse.responseData);
      List<TaskStatusDataModel> allTaskList = taskStatusModel.taskList ?? [];
      return allTaskList;
      //return true;
    } else {
      return [];
      //return false;
    }
  }
}
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/data/models/task_status_data_model.dart';
import 'package:task_manager_with_get_x/data/models/task_status_model.dart';
import 'package:task_manager_with_get_x/data/network_callers.dart';
import 'package:task_manager_with_get_x/data/network_respone.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class CompletedTaskController extends GetxController {
  bool getCompletedTaskInProgress = false;

  Future<List<TaskStatusDataModel>> getCompletedTaskRequest () async {
    getCompletedTaskInProgress = true;
    update();
    NetworkResponse networkResponse = await NetworkCallers.getRequestAPI(AssetPathsAndUrls.completedTaskURL);

    getCompletedTaskInProgress = false;
    update();
    if(networkResponse.isSuccess) {
      TaskStatusModel taskStatusModel = TaskStatusModel.fromJson(networkResponse.responseData);
      List<TaskStatusDataModel> completedTask = taskStatusModel.taskList ?? [];
      return completedTask;
    }
    else {
      return [];
    }
  }
}
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/data/models/task_status_data_model.dart';
import 'package:task_manager_with_get_x/data/models/task_status_model.dart';
import 'package:task_manager_with_get_x/data/network_callers.dart';
import 'package:task_manager_with_get_x/data/network_respone.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class AllTasksController extends GetxController {
  bool allTaskInProgress = false;

  Future<List<TaskStatusDataModel>> getAllTasks() async {
    List<TaskStatusDataModel> allTask = [];
    allTaskInProgress = true;
    update();

    NetworkResponse networkResponseOfNew =
        await NetworkCallers.getRequestAPI(AssetPathsAndUrls.newTaskURL);
    if (networkResponseOfNew.isSuccess) {
      TaskStatusModel taskStatusModel =
          TaskStatusModel.fromJson(networkResponseOfNew.responseData);
      allTask = taskStatusModel.taskList ?? [];
    }

    NetworkResponse networkResponseOfCompleted =
        await NetworkCallers.getRequestAPI(AssetPathsAndUrls.completedTaskURL);
    if (networkResponseOfCompleted.isSuccess) {
      TaskStatusModel taskStatusModel =
          TaskStatusModel.fromJson(networkResponseOfCompleted.responseData);
      allTask.addAll(taskStatusModel.taskList ?? []);
    }

    NetworkResponse networkResponseOfInProgress =
        await NetworkCallers.getRequestAPI(AssetPathsAndUrls.inProgressTaskURL);
    if (networkResponseOfInProgress.isSuccess) {
      TaskStatusModel taskStatusModel =
      TaskStatusModel.fromJson(networkResponseOfInProgress.responseData);
      allTask.addAll( taskStatusModel.taskList ?? []);
    }

    NetworkResponse networkResponseOfCancelled =
        await NetworkCallers.getRequestAPI(AssetPathsAndUrls.cancelledTaskURL);
    if (networkResponseOfCancelled.isSuccess) {
      TaskStatusModel taskStatusModel =
      TaskStatusModel.fromJson(networkResponseOfCancelled.responseData);
      allTask.addAll( taskStatusModel.taskList ?? []);
    }

    allTaskInProgress = false;
    update();

    return allTask;
  }
}

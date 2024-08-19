import 'package:get/get.dart';
import 'package:task_manager_with_get_x/data/network_callers.dart';
import 'package:task_manager_with_get_x/data/network_respone.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class CreateTaskController extends GetxController {
  bool createTaskInProgress = false;

  Future<bool> createTaskRequest (String title, String description, String status) async {
    createTaskInProgress = true;
    update();
    Map <String, String> createTaskData = {
      "title": title,
      "description": description,
      "status": status
    };
    final NetworkResponse networkResponse = await NetworkCallers.postRequestAPI(AssetPathsAndUrls.createTaskURL, createTaskData);
    createTaskInProgress = false;
    update();

    if(networkResponse.isSuccess){
      return true;
    } else {
      return false;
    }
  }


}
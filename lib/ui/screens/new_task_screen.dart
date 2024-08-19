import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/new_task_controller.dart';
import 'package:task_manager_with_get_x/data/models/task_status_data_model.dart';
import 'package:task_manager_with_get_x/ui/widgets/task_widget.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List<TaskStatusDataModel> newTasks = [];

  Future<void> _getNewTask() async {
    newTasks = await Get.find<NewTaskController>()
        .getNewTask(AssetPathsAndUrls.newTaskURL);
    if(mounted) {
      if (newTasks.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Successful"),
            duration: Duration(milliseconds: 500),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed"),
            duration: Duration(milliseconds: 500),
          ),
        );
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    _getNewTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GetBuilder<NewTaskController>(
        builder: (newTaskController) {
          return RefreshIndicator(
            onRefresh: _getNewTask,
            child: Visibility(
              visible: newTaskController.getNewTaskInProgress == false,
              replacement: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
              child: ListView.builder(
                itemCount: newTasks.length,
                itemBuilder: (context, index) {
                  return TaskWidget(
                    title: newTasks[index].title.toString(),
                    description: newTasks[index].description.toString(),
                    status: newTasks[index].status.toString(),
                    datTime: newTasks[index].createdDate.toString(),
                    taskId: newTasks[index].sId.toString(),
                    onDeleted: _getNewTask,
                    onEdited: _getNewTask,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

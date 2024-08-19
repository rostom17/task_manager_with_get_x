import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/in_progress_task_controller.dart';
import 'package:task_manager_with_get_x/data/models/task_status_data_model.dart';
import 'package:task_manager_with_get_x/ui/widgets/task_widget.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  List<TaskStatusDataModel> inProgressTasks = [];

  Future<void> _getInProgressTasks() async {
    inProgressTasks =
        await Get.find<InProgressTaskController>().getInProgressTasksRequest();
  }

  @override
  void initState() {
    _getInProgressTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GetBuilder<InProgressTaskController>(
        builder: (inProgressController) {
          return RefreshIndicator(
            onRefresh: _getInProgressTasks,
            child: Visibility(
              visible: inProgressController.getInProgressTaskIsLoading == false,
              replacement: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
              child: ListView.builder(
                itemCount: inProgressTasks.length,
                itemBuilder: (context, index) {
                  return TaskWidget(
                    title: inProgressTasks[index].title.toString(),
                    description: inProgressTasks[index].description.toString(),
                    status: inProgressTasks[index].status.toString(),
                    datTime: inProgressTasks[index].createdDate.toString(),
                    taskId: inProgressTasks[index].sId.toString(),
                    onDeleted: _getInProgressTasks,
                    onEdited: _getInProgressTasks,
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

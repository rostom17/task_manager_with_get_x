import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/completed_task_controller.dart';
import 'package:task_manager_with_get_x/data/models/task_status_data_model.dart';
import 'package:task_manager_with_get_x/ui/widgets/task_widget.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  List<TaskStatusDataModel> completedTask = [];

  @override
  void initState() {
    _getCompletedTask();
    super.initState();
  }

  Future<void> _getCompletedTask() async {
    completedTask =
        await Get.find<CompletedTaskController>().getCompletedTaskRequest();
    if (mounted) {
      if (completedTask.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("SuccessFull completed"),
            duration: Duration(milliseconds: 500),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed completed"),
            duration: Duration(milliseconds: 500),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GetBuilder<CompletedTaskController>(
        builder: (completedTaskController) {
          return RefreshIndicator(
            onRefresh: _getCompletedTask,
            child: Visibility(
              visible: completedTaskController.getCompletedTaskInProgress == false,
              replacement: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
              child: ListView.builder(
                itemCount: completedTask.length,
                itemBuilder: (context, index) {
                  return TaskWidget(
                    title: completedTask[index].title.toString(),
                    description: completedTask[index].description.toString(),
                    status: completedTask[index].status.toString(),
                    datTime: completedTask[index].createdDate.toString(),
                    taskId: completedTask[index].sId.toString(),
                    onDeleted: _getCompletedTask,
                    onEdited: _getCompletedTask,
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

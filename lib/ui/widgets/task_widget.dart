import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/delete_task_controller.dart';
import 'package:task_manager_with_get_x/controllers/drop_down_menu_controller.dart';
import 'package:task_manager_with_get_x/controllers/update_task_controller.dart';
import 'package:task_manager_with_get_x/data/available_status.dart';
import 'package:task_manager_with_get_x/ui/theme/app_theme.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    required this.datTime,
    required this.taskId,
    required this.onDeleted,
    required this.onEdited,
  });

  final String title;
  final String description;
  final String status;
  final String datTime;
  final String taskId;
  final void Function() onDeleted;
  final void Function() onEdited;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.green.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const SizedBox(
              height: 100,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(1),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(.6),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text("Date: ${widget.datTime.replaceAll('-', '/')}", style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 8,
                  ),
                  Chip(
                    label: Text(
                      widget.status,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    //color: widget.status == 'New' ? Colors.green : Colors.orange,
                    backgroundColor: getChipColor(widget.status),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              children: [
                IconButton(
                  onPressed: onPressedUpdateButton,
                  icon: const Icon(
                    Icons.edit_calendar_outlined,
                    color: Colors.green,
                    size: 26,
                  ),
                ),
                GetBuilder<DeleteTaskController>(
                  builder: (deleteController) {
                    return IconButton(
                      onPressed: () {
                        onPressedDeleteButton();
                      },
                      icon: const Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red,
                        size: 29,
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onPressedDeleteButton() {
    showDialog(
      context: context,
      builder: (context) => GetBuilder<DeleteTaskController>(
        builder: (deleteController) => Visibility(
          visible: deleteController.deleteTakInProgress == false,
          replacement: const Center(child: CircularProgressIndicator()),
          child: AlertDialog(
            title: const Text(
              "Are You Sure??",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Icon(
              Icons.question_mark,
              size: 60,
              color: Colors.red,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _onPressedConfirmDelete(widget.taskId);
                },
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.green),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Cancel",
                  style:
                      TextStyle(fontWeight: FontWeight.w800, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedConfirmDelete(String id) {
    _deleteItem(id);
  }

  Future<void> _deleteItem(String id) async {
    bool result = await Get.find<DeleteTaskController>().deleteTaskRequest(id);
    if (result) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Successfully Deleted the Item"),
          ),
        );
        widget.onDeleted();
        Get.back();
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to Delete The Item"),
          ),
        );
        Get.back();
      }
    }
  }

  void onPressedUpdateButton() {
    final DropDownMenuItemController _dropDownController =
        Get.put(DropDownMenuItemController());
    showDialog(
      context: context,
      builder: (context) =>
          GetBuilder<UpdateTaskController>(builder: (updateController) {
        return Visibility(
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          visible: updateController.updateTaskInProgress == false,
          child: AlertDialog(
            title: const Text(
              "Provide Status",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(
                  () => DropdownButton(
                    value: _dropDownController.currentStatus.value,
                    icon: const Icon(Icons.menu),
                    isExpanded: true,
                    underline: Container(),
                    items: AvailableStatus.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.name,
                              style: const TextStyle(color: Colors.deepPurple),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(
                        () {
                          _dropDownController.currentStatus.value = value;
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _onPressedConfirmEdit(_dropDownController.currentStatus.value
                      .toString()
                      .split('.')
                      .last);
                },
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.green),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Cancel",
                  style:
                      TextStyle(fontWeight: FontWeight.w800, color: Colors.red),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<void> _onPressedConfirmEdit(String status) async {
    bool result = await Get.find<UpdateTaskController>()
        .updateTaskRequest(widget.taskId, status);
    if (result) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Successfully Edited the Item"),
          ),
        );
        widget.onEdited;
        Get.back();
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to Edit The Item!! Try Again??"),
          ),
        );
      }
    }
  }
}

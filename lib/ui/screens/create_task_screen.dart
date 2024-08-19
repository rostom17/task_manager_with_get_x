import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/add_new_task_controller.dart';
import 'package:task_manager_with_get_x/data/available_status.dart';
import 'package:task_manager_with_get_x/ui/widgets/appbar_widget.dart';
import 'package:task_manager_with_get_x/ui/widgets/background_widget.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _titleTEC = TextEditingController();
  final TextEditingController _descriptionTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AvailableStatus _selectedStatus = AvailableStatus.New;

  void onTapCreateButton() {
    if (_formKey.currentState!.validate()) {
      _createTask();
    }
  }

  Future<void> _createTask() async {
    bool result = await Get.find<CreateTaskController>().createTaskRequest(
        _titleTEC.text.trim(),
        _descriptionTEC.text.trim(),
        _selectedStatus.toString().split('.').last
        );
    if (result) {
      _clearTextFields();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Successfully added a New Task"),
          ),
        );
        Get.back();
      }
      //Get.back();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed! to add new Task. Try again?"),
          ),
        );
      }
    }
  }

  void _clearTextFields() {
    _titleTEC.clear();
    _descriptionTEC.clear();
  }

  @override
  void dispose() {
    _titleTEC.dispose();
    _descriptionTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: BackgroundWidget(
        backGroundChildWidget: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    "Add New Task",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _titleTEC,
                    decoration: const InputDecoration(hintText: 'Title'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty == true) {
                        return "Enter Title";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _descriptionTEC,
                    decoration: const InputDecoration(hintText: 'Description'),
                    maxLines: 6,
                    validator: (String? value) {
                      if (value?.trim().isEmpty == true) {
                        return "Enter Description";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildDropDownButton(),
                  const SizedBox(height: 20,),
                  GetBuilder<CreateTaskController>(
                    builder: (createTask) {
                      return Visibility(
                        visible: createTask.createTaskInProgress == false,
                        replacement: const Center(child: CircularProgressIndicator(),),
                        child: ElevatedButton(
                          onPressed: onTapCreateButton,
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DecoratedBox _buildDropDownButton() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DropdownButton(
          value: _selectedStatus,
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
            setState(() {
              _selectedStatus = value;
            });
          },
        ),
      ),
    );
  }
}

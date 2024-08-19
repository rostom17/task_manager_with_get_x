import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_with_get_x/controllers/authentication_controller.dart';
import 'package:task_manager_with_get_x/controllers/update_profile_controller.dart';
import 'package:task_manager_with_get_x/ui/widgets/background_widget.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key, required this.onUpdate});

  final void Function () onUpdate ;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEc = TextEditingController();
  final TextEditingController _firstNameTEc = TextEditingController();
  final TextEditingController _lasNameTEc = TextEditingController();
  final TextEditingController _mobileTEc = TextEditingController();
  final TextEditingController _passwordTEc = TextEditingController();
  XFile? _selectedImage;

  @override
  void initState() {
    final userData = AuthenticationController.userData!;
    _emailTEc.text = userData.email ?? "";
    _firstNameTEc.text = userData.firstName ?? "";
    _lasNameTEc.text = userData.lastName ?? "";
    _mobileTEc.text = userData.mobile ?? "";
    super.initState();
  }

  void _onPressedUpdateButton() {
    if (_formKey.currentState!.validate() == true) {
      File file = File(_selectedImage!.path);

      Map<String, dynamic> updateData = {
        "email": _emailTEc.text.trim(),
        "firstName": _firstNameTEc.text.trim(),
        "lastName": _lasNameTEc.text.trim(),
        "mobile": _mobileTEc.text.trim(),
        "password": _passwordTEc.text.trim(),
        "photo" : base64Encode(file.readAsBytesSync())
      };
      _updateRequest(updateData);
    }
  }

  Future<void> _updateRequest(Map<String, dynamic> updateData) async {
    bool result = await Get.find<UpdateProfileController>()
        .updateProfileRequest(updateData);

    if (result) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile Update Successful"),
          ),
        );
        _clearTextFields();
        Get.back();
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile Update Successful"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        backGroundChildWidget: SafeArea(
          child: SingleChildScrollView(
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
                      'Update Profile',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildPhotoPicker(),
                    const SizedBox(
                      height: 25,
                    ),
                    _buildTextFormField(
                        true, "Email", "Enter Your Email", _emailTEc),
                    const SizedBox(
                      height: 25,
                    ),
                    _buildTextFormField(false, "First Name",
                        "Enter Your First Name", _firstNameTEc),
                    const SizedBox(
                      height: 25,
                    ),
                    _buildTextFormField(false, "Last Name",
                        "Enter Your Last Name", _lasNameTEc),
                    const SizedBox(
                      height: 25,
                    ),
                    _buildTextFormField(false, "Mobile Number",
                        "Enter Your Valid Mobile Number", _mobileTEc),
                    const SizedBox(
                      height: 25,
                    ),
                    _buildTextFormField(
                        false, "Password", "Enter Your Password", _passwordTEc),
                    const SizedBox(
                      height: 25,
                    ),
                    GetBuilder<UpdateProfileController>(
                      builder: (updateProfileController) {
                        return Visibility(
                          visible:  updateProfileController.updateInProgress == false,
                          replacement: const Center(child: CircularProgressIndicator(),),
                          child: ElevatedButton(
                            onPressed: _onPressedUpdateButton,
                            child: const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField(bool isEmail, String hintText,
      String warning, TextEditingController value) {
    return TextFormField(
      controller: value,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      enabled: isEmail ? false : true,
      validator: (String? value) {
        if (value?.trim().isEmpty == true) {
          return warning;
        } else {
          return null;
        }
      },
    );
  }

  GestureDetector _buildPhotoPicker() {
    return GestureDetector(
      onTap: chooseProfileImage,
      child: Container(
        width: double.maxFinite,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              width: 100,
              height: 48,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                color: Colors.grey,
              ),
              alignment: Alignment.center,
              child: const Text(
                'Photo',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(width: 10,),

            Expanded(child: Text(_selectedImage?.name ?? "NO Image Selected",maxLines: 1, style: const TextStyle(overflow: TextOverflow.ellipsis),),),
          ],
        ),
      ),
    );
  }

  Future<void> chooseProfileImage () async {
    final imagePicker = ImagePicker();
    final XFile? result = await imagePicker.pickImage(source: ImageSource.camera);

    if(result != null) {
      _selectedImage = result;
      if(mounted) {
        setState(() {
        });
      }
    }
  }

  void _clearTextFields () {
    _emailTEc.clear();
    _firstNameTEc.clear();
    _lasNameTEc.clear();
    _mobileTEc.clear();
    _passwordTEc.clear();
  }

  @override
  void dispose() {
    _emailTEc.dispose();
    _firstNameTEc.dispose();
    _lasNameTEc.dispose();
    _mobileTEc.dispose();
    _passwordTEc.dispose();
    super.dispose();
  }

}

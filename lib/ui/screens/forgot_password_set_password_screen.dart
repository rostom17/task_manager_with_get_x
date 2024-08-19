import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/forgot_password_controller.dart';
import 'package:task_manager_with_get_x/ui/screens/log_in_screen.dart';
import 'package:task_manager_with_get_x/ui/widgets/background_widget.dart';

class ForgotPasswordSetPasswordScreen extends StatefulWidget {
  const ForgotPasswordSetPasswordScreen({super.key});

  @override
  State<ForgotPasswordSetPasswordScreen> createState() =>
      _ForgotPasswordSetPasswordScreenState();
}

class _ForgotPasswordSetPasswordScreenState
    extends State<ForgotPasswordSetPasswordScreen> {
  final TextEditingController _newPasswordTEc = TextEditingController();
  final TextEditingController _confirmPasswordTEc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        backGroundChildWidget: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 180,
                  ),
                  Text(
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Minimum length 8 with Letter and Number and Special Character combined',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _newPasswordTEc,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'New Password',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _confirmPasswordTEc,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<ForgotPasswordController>(
                      builder: (forgotController) {
                    return Visibility(
                      visible: forgotController.setPasswordInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_newPasswordTEc.text ==
                              _confirmPasswordTEc.text) {
                            onPressedResetPassword();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Enter Same Password"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: const Text('Confirm'),
                      ),
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Now Please Sign In',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offAll(() => const LogInScreen());
                        },
                        child: const Text('Sign in'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onPressedResetPassword() async {
    bool result = await Get.find<ForgotPasswordController>()
        .setPassword(_confirmPasswordTEc.text);

    if (result) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Reset Password Successful.!\nPlease Login for User Access"),
            backgroundColor: Colors.green,
          ),
        );
        _clearTextFiled();
        Get.offAll(()=> const LogInScreen());
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Reset Password Failed.!\nTryAgain"),
          ),
        );
      }
    }
  }

  void _clearTextFiled () {
    _newPasswordTEc.clear();
    _confirmPasswordTEc.clear();
  }

  @override
  void dispose() {
    _confirmPasswordTEc.dispose();
    _newPasswordTEc.dispose();
    super.dispose();
  }
}

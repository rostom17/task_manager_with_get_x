import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/forgot_password_controller.dart';
import 'package:task_manager_with_get_x/ui/screens/forgot_password_pin_verify_screen.dart';
import 'package:task_manager_with_get_x/ui/widgets/background_widget.dart';

class ForgotPasswordEmailVerifyScreen extends StatefulWidget {
  const ForgotPasswordEmailVerifyScreen({super.key});

  @override
  State<ForgotPasswordEmailVerifyScreen> createState() =>
      _ForgotPasswordEmailVerifyScreenState();
}

class _ForgotPasswordEmailVerifyScreenState
    extends State<ForgotPasswordEmailVerifyScreen> {
  final TextEditingController _emailTEc = TextEditingController();

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
                  height: 250,
                ),
                Text(
                  'Your Email Address',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'A 6 digit verification pin will send to your email Address',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailTEc,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<ForgotPasswordController>(
                  builder: (forgotController) {
                    return Visibility(
                      visible: forgotController.emailVerificationInProgress == false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: ElevatedButton(
                        onPressed: _onPressedElevateButton,
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    );
                  }
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Have account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
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
    ));
  }

  Future<void> _onPressedElevateButton() async {
    bool result = await Get.find<ForgotPasswordController>().getEmailVerificationRequest(_emailTEc.text.trim());
    if(result) {
      Get.to(()=> const  ForgotPasswordPinVerifyScreen());
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed.! Try Again")));
      }
    }
  }
}

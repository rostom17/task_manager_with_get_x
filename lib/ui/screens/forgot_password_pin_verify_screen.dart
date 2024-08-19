import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/forgot_password_controller.dart';
import 'package:task_manager_with_get_x/ui/screens/forgot_password_set_password_screen.dart';
import 'package:task_manager_with_get_x/ui/screens/log_in_screen.dart';
import 'package:task_manager_with_get_x/ui/widgets/background_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordPinVerifyScreen extends StatefulWidget {
  const ForgotPasswordPinVerifyScreen({super.key});

  @override
  State<ForgotPasswordPinVerifyScreen> createState() =>
      _ForgotPasswordPinVerifyScreenState();
}

class _ForgotPasswordPinVerifyScreenState
    extends State<ForgotPasswordPinVerifyScreen> {
  final TextEditingController _pinTEc = TextEditingController();

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
                    height: 200,
                  ),
                  Text(
                    'PIN Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text('A six digit PIN has sent to your email address',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 20,
                  ),
                  PinCodeTextField(
                    controller: _pinTEc,
                    keyboardType: TextInputType.number,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.grey.shade200,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.grey.shade400,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    appContext: context,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<ForgotPasswordController>(
                    builder: (forgotController) {
                      return Visibility(
                        visible: forgotController.pinVerificationInProgress == false,
                        replacement: const Center(child: CircularProgressIndicator(),),
                        child: ElevatedButton(
                          onPressed: _onPressedVerify,
                          child: const Text('Verify'),
                        ),
                      );
                    }
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
                        onPressed: (){
                          Get.off(()=> const LogInScreen());
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

  Future<void> _onPressedVerify() async {
    String x = _pinTEc.text;
    debugPrint('\n\n\n$x\n\n\n');
    bool result = await Get.find<ForgotPasswordController>().verifyPinRequest(_pinTEc.text);
    if(result) {
      Get.to(()=> const ForgotPasswordSetPasswordScreen());
    } else {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid Pin.!\nTry Again.?")));
      }
    }
  }
}

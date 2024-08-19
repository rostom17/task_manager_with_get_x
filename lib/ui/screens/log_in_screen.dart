import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/login_controller.dart';
import 'package:task_manager_with_get_x/ui/screens/forgot_password_email_verify_screen.dart';
import 'package:task_manager_with_get_x/ui/screens/main_bottom_navigation_screen.dart';
import 'package:task_manager_with_get_x/ui/screens/sign_up_screen.dart';
import 'package:task_manager_with_get_x/ui/widgets/background_widget.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailTEc = TextEditingController();
  final TextEditingController _passwordTEc = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> onPressedLoginButton () async {
    if(_formKey.currentState!.validate()){
      final bool result  = await Get.find<LoginController>().signInRequest(_emailTEc.text.trim(), _passwordTEc.text);

      if(result) {
        _clearInputFields();
        Get.to (()=> const MainBottomNavigationScreen());
      } else {
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed TO Login! Try Again."),),);
        }
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    Text(
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
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
                      validator: (String? value) {
                        if (value?.trim().isEmpty == true) {
                          return "Enter your email";
                        } else if (AssetPathsAndUrls.emailChecker.hasMatch(value!) ==
                            false) {
                          return 'Enter valid email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GetBuilder<LoginController>(
                      builder: (loginController) {
                        return TextFormField(
                          obscureText: loginController.passwordVisible == false,
                          controller: _passwordTEc,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                loginController.onPressedShowPasswordIcon();
                              },
                              icon: Icon(
                                loginController.passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              iconSize: 28,
                            ),
                          ),
                          validator: (String? value) {
                            if (value?.trim().isEmpty == true) {
                              return "Enter your password";
                            } else {
                              return null;
                            }
                          },
                        );
                      }
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GetBuilder<LoginController>(
                      builder: (loginController) {
                        return Visibility(
                          visible: loginController.loginInProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: onPressedLoginButton,
                            child: const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      }
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.to(()=>const ForgotPasswordEmailVerifyScreen());
                            },
                            child: const Text(
                              'Forgot Password.!',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have account?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(()=> const SignUpScreen());
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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


  @override
  void dispose() {
    _emailTEc.dispose();
    _passwordTEc.dispose();
    super.dispose();
  }

  void _clearInputFields(){
    _emailTEc.clear();
    _passwordTEc.clear();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_get_x/controllers/sign_up_controller.dart';
import 'package:task_manager_with_get_x/ui/screens/log_in_screen.dart';
import 'package:task_manager_with_get_x/ui/widgets/background_widget.dart';
import 'package:task_manager_with_get_x/utilities/asset_paths_and_urls.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEc = TextEditingController();
  final TextEditingController _firstNameTEc = TextEditingController();
  final TextEditingController _lastNameTEc = TextEditingController();
  final TextEditingController _mobileNumTEc = TextEditingController();
  final TextEditingController _passwordTEc = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onPressedSignUpButton() async {
    if (_formKey.currentState!.validate()) {
      final bool result = await Get.find<SignUpController>().signUpRequest(
          _emailTEc.text,
          _firstNameTEc.text,
          _lastNameTEc.text,
          _mobileNumTEc.text,
          _passwordTEc.text);
      if (result) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Registration Successful"),
              content: const Text("Please SignIn for now for get Access?"),
              actions: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
          );
        }
        _clearTextField();
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Registration Failed.! Try Again',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          );
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      'Join With Us',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    buildTextFormField(
                        "Email", "Enter your Email please", _emailTEc),
                    const SizedBox(
                      height: 20,
                    ),
                    buildTextFormField(
                        "First Name", "Enter your First Name", _firstNameTEc),
                    const SizedBox(
                      height: 15,
                    ),
                    buildTextFormField(
                        "Last Name", "Enter your Last Name", _lastNameTEc),
                    const SizedBox(
                      height: 15,
                    ),
                    buildTextFormField("Mobile Number",
                        "Enter your Mobile Number please", _mobileNumTEc),
                    const SizedBox(
                      height: 15,
                    ),
                    GetBuilder<SignUpController>(
                      builder: (signUpController) {
                        return TextFormField(
                          controller: _passwordTEc,
                          obscureText: signUpController.showPassword == false,
                          //maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                signUpController.onPressedShowPasswordIcon();
                              },
                              icon: Icon(
                                signUpController.showPassword
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
                    GetBuilder<SignUpController>(builder: (signUpController) {
                      return Visibility(
                        visible: signUpController.signUpInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: _onPressedSignUpButton,
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Have account?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(()=> const LogInScreen());
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
      ),
    );
  }

  TextFormField buildTextFormField(
    String hintText,
    String warning,
    TextEditingController inputValue,
  ) {
    return TextFormField(
      controller: inputValue,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: hintText == 'Email'
          ? (String? value) {
              if (value?.trim().isEmpty == true) {
                return warning;
              } else if (AssetPathsAndUrls.emailChecker.hasMatch(value!) ==
                  false) {
                return "Enter Valid Email!";
              } else {
                return null;
              }
            }
          : (String? value) {
              if (value?.trim().isEmpty == true) {
                return warning;
              } else {
                return null;
              }
            },
    );
  }

  void _clearTextField() {
    _emailTEc.clear();
    _firstNameTEc.clear();
    _lastNameTEc.clear();
    _mobileNumTEc.clear();
    _passwordTEc.clear();
  }

  @override
  void dispose() {
    _emailTEc.dispose();
    _firstNameTEc.dispose();
    _lastNameTEc.dispose();
    _mobileNumTEc.dispose();
    _passwordTEc.dispose();
    super.dispose();
  }
}

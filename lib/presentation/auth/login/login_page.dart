import 'package:auto_route/auto_route.dart';
import 'package:chat_system/core/constants.dart';
import 'package:chat_system/infrastructure/auth/auth_repository.dart';
import 'package:chat_system/presentation/chat/chat_page.dart';
import 'package:chat_system/presentation/common_widgets/custom_button.dart';
import 'package:chat_system/presentation/common_widgets/custom_text_field.dart';
import 'package:chat_system/presentation/room/room_page.dart';
import 'package:chat_system/presentation/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Image.asset(
                  //   'assets/images/scholar.png',
                  // ),
                  const Text(
                    'Scholar Chat ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: 'pacifico',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormFiled(
                    onChanged: (value) {
                      email = value;
                    },
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormFiled(
                    securedPassword: true,
                    onChanged: (value) {
                      password = value;
                    },
                    hintText: 'Password',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onPressed: () async {
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await AuthRepository.loginUser(
                              email: email!, password: password!);
                        } on FirebaseAuthException catch (e) {
                          String message = '';
                          if (e.code == 'user-not-found') {
                            message = 'No user found for that email.';
                          } else if (e.code == 'wrong-password') {
                            message = 'Wrong password provided for that user.';
                          } else {
                            message = e.message ??
                                'An error occurred. Please try again.';
                          }
                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              content: Text(message),
                            ),
                          );
                        } catch (e) {
                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                            content: Text('Please enter valid data'),
                          ),
                        );
                      }
                    },
                    text: 'LOGIN',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          AutoRouter.of(context).push(const RegisterRoute());
                          // Navigator.pushNamed(
                          //   context,
                          //   RegisterPage.registerRoute,
                          // );
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

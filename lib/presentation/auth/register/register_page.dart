import 'package:auto_route/auto_route.dart';
import 'package:chat_system/core/constants.dart';
import 'package:chat_system/infrastructure/auth/auth_repository.dart';
import 'package:chat_system/presentation/chat/chat_page.dart';
import 'package:chat_system/presentation/common_widgets/custom_button.dart';
import 'package:chat_system/presentation/common_widgets/custom_text_field.dart';
import 'package:chat_system/presentation/routes/routes.dart';
import 'package:chat_system/presentation/splash/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  String? email;
  String? password;
  String? username;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
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
                      'REGISTER',
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
                    onChanged: (data) {
                      username = data;
                    },
                    hintText: 'Username',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormFiled(
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormFiled(
                    onChanged: (data) {
                      password = data;
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
                          await AuthRepository.registerUser(
                              username: username!,
                              email: email!,
                              password: password!);
                          AutoRouter.of(context).maybePop();
                          // Navigator.pushNamed(context, ChatPage.chatRoute,
                          //     arguments: email);
                        } on FirebaseAuthException catch (e) {
                          String message = '';
                          if (e.code == 'weak-password') {
                            message = 'The password provided is too weak.';
                          } else if (e.code == 'email-already-in-use') {
                            message =
                                'The account already exists for that email.';
                          } else {
                            message = e.message ?? 'An unknown error occurred.';
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
                    text: 'REGISTER',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'LOGIN',
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

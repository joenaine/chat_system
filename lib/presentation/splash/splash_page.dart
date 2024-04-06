import 'package:auto_route/auto_route.dart';
import 'package:chat_system/presentation/auth/login/login_page.dart';
import 'package:chat_system/presentation/room/room_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (BuildContext context, snapshot) {
        final userChanges = snapshot.data;
        if (userChanges?.uid != null) {
          return const RoomPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:chat_system/domain/user_dto.dart';
import 'package:chat_system/infrastructure/auth/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RoomPage extends StatelessWidget {
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthRepository.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          FirebaseAuth.instance.currentUser!.email.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<UserModel> usersList = [];
            for (var element in snapshot.data!.docs) {
              usersList.add(UserModel.fromMap(element.data()));
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: usersList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(usersList[index].email ?? ''));
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

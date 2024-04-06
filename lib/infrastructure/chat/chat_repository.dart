import 'package:chat_system/domain/message_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepository {
  Future<bool> submitMessage(
      {required String id, required Message message}) async {
    try {
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('userMessages')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set(message.toMap())
          .then((value) => true);
    } catch (e) {
      return false;
    }
  }
}

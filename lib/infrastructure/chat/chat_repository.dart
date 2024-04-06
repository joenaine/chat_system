import 'package:chat_system/domain/message_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepository {
  static Future<void> submitMessage(
      {required String id, required Message message}) async {
    try {
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('userMessages')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'id': FirebaseAuth.instance.currentUser?.uid,
        'messages': FieldValue.arrayUnion([message.toJson()])
      }).then((value) => true);
    } catch (e) {}
  }
}

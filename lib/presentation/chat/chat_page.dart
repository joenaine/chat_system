import 'package:auto_route/auto_route.dart';
import 'package:chat_system/core/constants.dart';
import 'package:chat_system/domain/message_dto.dart';
import 'package:chat_system/presentation/common_widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@RoutePage()
class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.id});
  final String id;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController conroller = ScrollController();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String id = widget.id;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .collection('userMessages')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('myMessages')
            .orderBy('createdAt')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (var element in snapshot.data!.docs) {
              messagesList.add(Message.fromMap(element.data()));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                centerTitle: true,
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   'assets/images/scholar.png',
                    //   height: 50,
                    // ),
                    Text(
                      'Chat Page',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: conroller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id ==
                                FirebaseAuth.instance.currentUser?.uid
                            ? ChatBubble(
                                message: messagesList[index].message!,
                              )
                            : ChatBubbleForFriend(
                                message: messagesList[index].message!,
                              );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (value) {
                        messagesList.add(Message(
                            id: FirebaseAuth.instance.currentUser?.uid,
                            createdAt: DateTime.now(),
                            message: value));
                        controller.clear();
                        conroller.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            messagesList.add(Message(
                                id: FirebaseAuth.instance.currentUser?.uid,
                                createdAt: DateTime.now(),
                                message: controller.text.trim()));
                            controller.clear();
                            conroller.animateTo(
                              0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.fastOutSlowIn,
                            );
                          },
                          icon: const Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
                        hintText: 'Type a message',
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        });
  }
}

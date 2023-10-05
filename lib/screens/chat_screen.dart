
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speso_chat_app/constants/colors.dart';
import 'package:speso_chat_app/constants/text_style.dart';
import 'package:speso_chat_app/utils/alert_dialogs.dart';

import '../widgets/input_field.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String routeName  = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                //Navigator.pop(context);
                openDialog(
                  LogOutDialog(),
                  context
                );
              }),
        ],
        title: Center(child: Text('⚡️Speso Chat')),
        backgroundColor: AppColors.blueColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20,),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: TextField(
                            controller: messageTextController,
                            onChanged: (value) {
                              messageText = value;
                            },
                            decoration: kMessageTextFieldDecoration

                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    InkWell(
                      onTap: () {
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          "text": messageText,
                          "sender": loggedInUser.email,
                        });
                      },
                       child: Icon(Icons.send, color: AppColors.blueColor, size: 30,)
                       //Text(
                      //   'Send',
                      //   style: kSendButtonTextStyle,
                      // ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.blueColor,
              ),
            );
          }
          final messages = snapshot.data.documents.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.data['text'];
            final messageSender = message.data['sender'];

            final currentUser = loggedInUser.email;

            final messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }

          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.sender, this.isMe});
  final String sender;
  final String text;
  bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            )
                : BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
              topRight:  Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: isMe ? AppColors.blueColor : AppColors.whiteColor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 15.0,
                    color: isMe ? AppColors.whiteColor : Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:chat/chatting/chat/message.dart';
import 'package:chat/chatting/chat/new_message.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat screen'),
          actions: [
            IconButton(
              onPressed: () {
                _authentication.signOut();
                //원래 아래 명령어로 스크린을 사라지게 해야하지만 main.dart 에서 인증상태를 스크림해서  그냥 윗 인증사인아웃으로 만 해줘도 된다
                // Navigator.pop(context);
              },
              icon: Icon(
                Icons.exit_to_app_sharp,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(   //컬럼이 화면전체를 차지하지 않게 하기위해
                child: Messages(),
              ),
              NewMessage(),
            ],
          ),
        ));
  }
}

// StreamBuilder(
// stream: FirebaseFirestore.instance
//     .collection('chats/zWxaIiWkAahkwMceIB5M/message')
// .snapshots(),
// builder: (BuildContext context,
//     AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
// if(snapshot.connectionState == ConnectionState.waiting){
// return Center(
// child: CircularProgressIndicator(),
// );
// }
// final docs = snapshot.data!.docs;
// return ListView.builder(
// itemCount: docs.length,
// itemBuilder: (context, index){
// return Container(
// padding: EdgeInsets.all(8.0),
// child: Text(docs[index]['text'],
// style: TextStyle(fontSize: 20),
// ),
// );
// },
// );
// },
// )

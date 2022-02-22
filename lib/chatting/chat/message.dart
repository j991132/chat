import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //스냅샷 전에 정렬을 시간순으로 해줘야 한다
      stream: FirebaseFirestore.instance
          .collection('chat')
      .orderBy('time', descending: true)
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,   //메세지가 아래에서부터 쌓여 올라가도록
          itemCount: chatDocs.length,
          itemBuilder: (context, index){
            return Text(chatDocs[index]['text']);
          },
        );
      },
    );
  }
}

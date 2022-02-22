import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
final _controller = TextEditingController();    // 텍스트필드를 조정할 컨트롤러 생성
  var _userEnterMessage = '';

  void _sendMessage(){
    //키보드 내리기
    FocusScope.of(context).unfocus();
    //파이어스토어 데이터 연동
    FirebaseFirestore.instance.collection('chat').add({
      'text' : _userEnterMessage,
      'time' : Timestamp.now()
    });
    _controller.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _userEnterMessage = value;
                });
              },
            ),
          ),
          IconButton(
            //삼항조건연산
            // 뒤에 _sendMessage() 를 안쓰는 이유는 onPressed 의 매개변수로 값만 참조하기위해서이다
            //_sendMessage()를 다쓰면 에러가 나는데 ()는 메서드를 실행하고 리턴값을 가져온다는 의미
            onPressed: _userEnterMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}

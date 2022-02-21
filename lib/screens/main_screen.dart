import 'package:chat/config/palette.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _authentication = FirebaseAuth.instance; //파이어베이스 인증을 위한 인스턴스 생성
  // 위의 인스턴스를 생성하면 사용자 등록, 로그인에 필요한 파이어베이스 메서드들을 사용할 수 있다
  bool isSignupScreen = true; // 삼항 조건문을위해 필요하다
  bool showSpinner = false;   // 프로그레스 인디케이터를 돌아가기 위해 선언
  final _formKey = GlobalKey<FormState>();

  // 텍스트필드 안에 입력된 값이 올바른 형태인지 체크하기위해 글로벌키를 만든다. 이 때 Form 위젯을 이용할 것이기 때문에  FormState를 써준다.
  // 이제 아래 폼위젯 안에 key 값으로 _formKey 를 넣어놓으면 연결된다.
  // 그 후에 제출버튼을 눌렀을 때 validator 가 작동하도록 매서드하나를 만들어서 넣는다.
  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    // 폼키를 이용해서 폼스테이트에 연결하려면 currentState를 이용하고 validate() 를 불러온다 이때 validate()는 커런트스테이트에서만 가져오기때문에 널값체크로 ! 를 해줘야 에러가 안난다.
    // 그 후에 validate()로 리턴된 유효성 결과를 담을 변수로 isValid 에 담는다. -> 이건 단순히 유효성 결과 null 인지 다른 리턴인지
    if (isValid) {
      _formKey.currentState!.save();
      //리턴된 유효성 결과값들을 각 form 에서 가져올 것이고 그걸 이용해서 다음 행동을 해야하기 때문에 폼에 값을 저장 save 해야한다.
      // save() 가 호출되면 폼 전체의 state 값을 저장하게 되는데 이 과정에서 모든 텍스트폼 필드가 가지고있는 onSaved 메서드를 작동시키게 된다.
      //그래서 각 텍스트폼 필드에 onSaved 메서드를 추가해주어야 한다.
    }
  }

  String userName = '';
  String userEmail = '';
  String userPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('image/red.jpg'),
                            fit: BoxFit.fill)),
                    child: Container(
                      padding: EdgeInsets.only(top: 90, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Welcome',
                                style: TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 25,
                                    color: Colors.white),
                                children: [
                                  TextSpan(
                                    text: isSignupScreen
                                        ? ' to Yummy chat!'
                                        : ' back',
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            isSignupScreen
                                ? 'Singnup to continue'
                                : 'Signin to continue',
                            style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              //배경

              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: 180,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  padding: EdgeInsets.all(20),
                  height: isSignupScreen ? 280 : 250,
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5)
                      ]),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: !isSignupScreen
                                            ? Palette.activeColor
                                            : Palette.textColor1),
                                  ),
                                  if (!isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 55,
                                      color: Colors.orange,
                                    )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'SIGNUP',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isSignupScreen
                                            ? Palette.activeColor
                                            : Palette.textColor1),
                                  ),
                                  if (isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 55,
                                      color: Colors.orange,
                                    )
                                ],
                              ),
                            )
                          ],
                        ),
                        if (isSignupScreen)
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Form(
                              // 로그인 밸류값 체크를 위해 폼 사용
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    key: ValueKey(1),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 4) {
                                        return '4글자 이상으로 적어주세요';
                                        //validator 리턴값은 텍스트폼필드 아래 보여진다
                                      }
                                      return null;
                                    },
                                    //맨위에 _tryValidation 메서드가 동작하여 save메서드가 호출될때마다 입력된 값을 변수에 담아 업데이트해준다
                                    onSaved: (value) {
                                      userName = value!;
                                    },
                                    //밸류값들이 입력될 때마다 변화를 감지하여 변수에 저장
                                    onChanged: (value) {
                                      userName = value;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.account_circle,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35),
                                          ),
                                        ),
                                        //입력창 선택되었을때 보더라인을 계속 보여주기 위해 포커스드 볼더 사용
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35),
                                          ),
                                        ),
                                        hintText: 'User name',
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10)),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    //이메일에 적합한 키보드 불러오기
                                    key: ValueKey(2),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !value.contains('@')) {
                                        return 'Please enter a valid email address.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userEmail = value!;
                                    },
                                    onChanged: (value) {
                                      userEmail = value;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.mail,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35),
                                          ),
                                        ),
                                        //입력창 선택되었을때 보더라인을 계속 보여주기 위해 포커스드 볼더 사용
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35),
                                          ),
                                        ),
                                        hintText: 'e-mail',
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10)),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    //비밀번호 노출 방지
                                    key: ValueKey(3),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 6) {
                                        return 'Password must be at least 7 characters long';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userPassword = value!;
                                    },
                                    onChanged: (value) {
                                      userPassword = value;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35),
                                          ),
                                        ),
                                        //입력창 선택되었을때 보더라인을 계속 보여주기 위해 포커스드 볼더 사용
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35),
                                          ),
                                        ),
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        if (!isSignupScreen)
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    key: ValueKey(4),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !value.contains('@')) {
                                        return 'Please enter a valid email address.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userEmail = value!;
                                    },
                                    onChanged: (value) {
                                      userEmail = value;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.mail,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35),
                                          ),
                                        ),
                                        //입력창 선택되었을때 보더라인을 계속 보여주기 위해 포커스드 볼더 사용
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35),
                                          ),
                                        ),
                                        hintText: 'e-mail',
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10)),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    key: ValueKey(5),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 6) {
                                        return 'Password must be at least 7 characters long';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      userPassword = value!;
                                    },
                                    onChanged: (value) {
                                      userPassword = value;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Palette.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35),
                                          ),
                                        ),
                                        //입력창 선택되었을때 보더라인을 계속 보여주기 위해 포커스드 볼더 사용
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Palette.textColor1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(35),
                                          ),
                                        ),
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1),
                                        contentPadding: EdgeInsets.all(10)),
                                  )
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
              //텍스트 폼 필드
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: isSignupScreen ? 430 : 400,
                right: 0,
                left: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {  //동적 변화 보여줄때 호출
                          showSpinner = true;    // 프로그레스 인디케이터 돌기 시작지점
                        });
                        if (isSignupScreen) {
                          _tryValidation();
                          try {
                            //아마도 이부분이 파이어베이스에 등록해주는 부분
                            final newUser = await _authentication
                                .createUserWithEmailAndPassword(
                              email: userEmail,
                              password: userPassword,
                            );
                            //아래 user 은 파이어베이스 auth 에서 사용하는 크레덴셜메서드의 한 속성이다
                            //널이 아니라는 경우는 사용자의 입력내용이 다 제대로 입력되어 있음을 의미
                            //채팅 스크린으로 페이지를 이동시켜야한다
                            if (newUser.user != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ChatScreen();
                              }));
                              setState(() {    // 프로그레스 인디케이터 중지 점
                                showSpinner = false;
                              });
                            }
                          } catch (e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Please check your email and password'),
                                backgroundColor: Colors.blue,
                              ),
                            );
                          }
                        }
                        if (!isSignupScreen) {
                          _tryValidation();
                          try {
                            final newUser =
                            await _authentication.signInWithEmailAndPassword(
                              email: userEmail,
                              password: userPassword,
                            );
                            if (newUser.user != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return ChatScreen();
                                  }));
                              setState(() {    // 프로그레스 인디케이터 중지 점
                                showSpinner = false;
                              });
                            }
                          }catch(e){
                            print(e);
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.orange, Colors.red],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //둥근 버튼
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: isSignupScreen
                    ? MediaQuery.of(context).size.height - 125
                    : MediaQuery.of(context).size.height - 165,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Text(isSignupScreen ? 'or Signup with' : 'or Signin with'),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: Size(155, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Palette.googleColor),
                      icon: Icon(Icons.add),
                      label: Text('Google'),
                    ),
                  ],
                ),
              ),
              //구글 로그인 버튼
            ],
          ),
        ),
      ),
    );
  }
}

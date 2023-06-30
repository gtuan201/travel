import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel/main.dart';
import 'package:travel/page/main_page.dart';
import 'package:travel/page/sign_up.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _email = "";
  var _password = "";
  var _enableButton = false;
  bool _showPassword = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffd6edff),Colors.white54,Color(0xcd97cbfc)]
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/logo2.png'),
                    ),
                    Text(
                      'Lavana',
                      style: TextStyle(
                          color: Color(0xff005C99),
                          fontWeight: FontWeight.w800,
                          fontSize: 50,
                          fontFamily: "Kanit-Bold"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Đăng nhập",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    fontSize: 25),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 52,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                      _enableButton =
                          (_email.isNotEmpty) && (_password.isNotEmpty);
                    });
                  },
                  decoration: InputDecoration(
                      label: const Text("Email"),
                      labelStyle: const TextStyle(color: Colors.black54),
                      hintText: 'Địa chỉ Email',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: const Icon(Icons.email),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff005C99)),
                          borderRadius: BorderRadius.all(Radius.circular(14)))),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 52,
                child: TextField(
                  obscureText: _showPassword,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                      _enableButton =
                          (_email.isNotEmpty) && (_password.isNotEmpty);
                    });
                  },
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    labelStyle: const TextStyle(color: Colors.black54),
                    hintText: 'Tối thiểu có 8 kí tự',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(Icons.lock,),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        icon: _showPassword
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff005C99)),
                        borderRadius: BorderRadius.all(Radius.circular(14))),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                    onPressed: _enableButton ? () {
                      setState(() {
                        _isLoading = true;
                      });
                      clickLogin();
                    } : null,
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: const Color(0xff005C99),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xffc7c7c7)),
                    child: _isLoading ?
                    const SizedBox(height: 28,width: 28,
                    child: CircularProgressIndicator(color: Colors.white,strokeWidth: 3.0,))
                        : const Text("Đăng nhập")),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                  height: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(48, 0, 48, 0),
                    child: Divider(
                      color: Color(0xffcececeff),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  const Text("Hoặc"),
                  SizedBox(
                    width: 260,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        //Đăng nhập với google
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          elevation: 5),
                      icon: SvgPicture.asset('assets/icon/google_icon.svg'),
                      label: const Text('Tiếp tục với Google'),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    width: 260,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        //Đăng nhập với facebook
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        elevation: 5,
                      ),
                      icon: SvgPicture.asset('assets/icon/icon_facebook.svg',color: const Color(0xff005C99),),
                      label: const Text('Tiếp tục với Facebook'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6,),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: (){goToPage(const SignUpPage());},
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Chưa có tài khoản? ',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)
                        ),
                        TextSpan(
                          text: 'Đăng ký',
                          style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)
                        )
                      ]
                  ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  Future<void> clickLogin() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password
      );
      setState(() {
        _isLoading = false;
      });
      goToPage(const MainPage());
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (e.code == 'user-not-found') {
        showToast('Tài khoản không tồn tại');
      } else if (e.code == 'wrong-password') {
        showToast('Mật khẩu không đúng!');
      }
      else {
        showToast('Email không hợp lệ !');
      }
    }
  }
  void showToast(String error){
    Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }

  void goToPage(Widget w) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) =>  w,
            transitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (_, a, __, c) => FadeTransition(
                  opacity: a,
                  child: c,
                )));
  }
}

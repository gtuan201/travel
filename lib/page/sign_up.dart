import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/page/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  bool _enable = false;
  String _email = "";
  String _name = "";
  String _password = "";
  String _repass = "";
  bool _showPass1 = true;
  bool _showPass2 = true;
  bool _isLoading = false;
  String _imagePath = "";
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0xffd6edff),
                Colors.white54,
                Colors.white70,
                Color(0xcd97cbfc)
              ])),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: InkWell(
                          onTap: (){_pickImage();},
                          child: Stack(
                            fit: StackFit.loose,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: (_imagePath.isEmpty) ? Border.all(
                                      color: Colors.black,
                                      width: 2.0,
                                    ) : null,
                                  ),
                                  child:   CircleAvatar(
                                    backgroundImage: (_imagePath.isEmpty) ?
                                    const AssetImage('assets/images/image_avatar.jpg') : FileImage(_imageFile!) as ImageProvider,
                                    radius: 62,
                                  )),
                              Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade400),
                                      child: const Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Icon(Icons.camera_alt),
                                      )))
                            ],
                          ),
                        ),
                      ),
                      const Text(
                        "Tạo tài khoản mới",
                        style: TextStyle(
                          color: Color(0xff005C99),
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                          fontFamily: "Kanit-Bold",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 54,
                        child: TextField(
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                                _enable = (_email.isNotEmpty) &&
                                    (_name.isNotEmpty) &&
                                    (_password.isNotEmpty) &&
                                    (_repass.isNotEmpty);
                              });
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                                label: const Text("Email"),
                                labelStyle:
                                    const TextStyle(color: Colors.black54),
                                hintText: 'Địa chỉ Email',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                prefixIcon: const Icon(Icons.email),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff005C99)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(14))))),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 54,
                        child: TextField(
                            onChanged: (value) {
                              setState(() {
                                _name = value;
                                _enable = (_email.isNotEmpty) &&
                                    (_name.isNotEmpty) &&
                                    (_password.isNotEmpty) &&
                                    (_repass.isNotEmpty);
                              });
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                                label: const Text("Tên của bạn"),
                                labelStyle:
                                    const TextStyle(color: Colors.black54),
                                hintText: 'Sẽ hiển thị trên Lavana',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                prefixIcon: const Icon(Icons.person),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff005C99)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(14))))),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 54,
                        child: TextField(
                            obscureText: _showPass1,
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                                _enable = (_email.isNotEmpty) &&
                                    (_name.isNotEmpty) &&
                                    (_password.isNotEmpty) &&
                                    (_repass.isNotEmpty);
                              });
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                                label: const Text("Mật khẩu"),
                                labelStyle:
                                    const TextStyle(color: Colors.black54),
                                hintText: 'Mật khẩu gồm ít nhất 8 kí tự',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: _showPass1
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _showPass1 = !_showPass1;
                                    });
                                  },
                                ),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff005C99)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(14))))),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 54,
                        child: TextField(
                            obscureText: _showPass2,
                            onChanged: (value) {
                              setState(() {
                                _repass = value;
                                _enable = (_email.isNotEmpty) &&
                                    (_name.isNotEmpty) &&
                                    (_password.isNotEmpty) &&
                                    (_repass.isNotEmpty);
                              });
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                                label: const Text("Nhập lại mật khẩu"),
                                labelStyle:
                                    const TextStyle(color: Colors.black54),
                                hintText: 'Nhập lại mật khẩu',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: _showPass2
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _showPass2 = !_showPass2;
                                    });
                                  },
                                ),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff005C99)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(14))))),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: _enable ? signUp : null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff005C99),
                            foregroundColor: Colors.white),
                        child: _isLoading
                            ? const SizedBox(
                                height: 28,
                                width: 28,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3.0,
                                ))
                            : const Text("Đăng ký"),
                      ),
                    ],
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Đã có tài khoản?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: goToLogin,
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void goToLogin() {
    Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (_, __, ___) => const Login(),
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (_, a, __, c) => FadeTransition(
                opacity: a,
                child: c,
              )),
    );
  }

  bool validateData() {
    return _password == _repass && _imagePath.isNotEmpty;
  }

  Future<void> signUp() async {
    setState(() {
      _isLoading = true;
    });
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (validateData()) {
      String error = "";
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        setState(() {
          _isLoading = false;
        });
        showToast('Đăng ký thành công ! Vui lòng đăng nhập');
        goToLogin();
        var user = FirebaseAuth.instance.currentUser;
        await user?.updateDisplayName(_name);
        await user?.updatePhotoURL(_imagePath);
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (e.code == 'weak-password') {
          error = 'Mật khẩu được cung cấp quá yếu!';
          showToast(error);
        } else if (e.code == 'email-already-in-use') {
          error = "Tài khoản đã tồn tại";
          showToast(error);
        }
      } catch (e) {
        showToast("Email không hợp lệ !");
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      showToast("Thiếu thông tin hoặc mật khẩu không khớp !");
    }
  }

  void showToast(String error) {
    Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white70,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  Future<void> _pickImage() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        _imageFile = File(_imagePath);
      });
    } else {
      print('No image selected.');
    }
  }
}

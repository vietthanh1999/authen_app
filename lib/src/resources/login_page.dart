import 'package:authen_app/src/blocs/login_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:authen_app/src/resources/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc = new LoginBloc();

  bool _showPass = false;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            // shrinkWrap: true,
            // reverse: true,
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                child: Container(
                    width: 70,
                    height: 70,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffd8d8d8)),
                    child: const FlutterLogo()),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 60.0),
                child: Text(
                  'Hello\nWelcome Back',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: StreamBuilder(
                    stream: bloc.userStream,
                    builder: (context, snapshot) => TextField(
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          controller: _userController,
                          decoration: InputDecoration(
                              labelText: 'USERNAME',
                              errorText: snapshot.hasError
                                  ? snapshot.error as String
                                  : null,
                              labelStyle: const TextStyle(
                                  color: Color(0xff888888), fontSize: 15)),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    StreamBuilder(
                        stream: bloc.passStream,
                        builder: (context, snapshot) => TextField(
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              controller: _passController,
                              obscureText: !_showPass,
                              decoration: InputDecoration(
                                  errorText: snapshot.hasError
                                      ? snapshot.error as String
                                      : null,
                                  labelText: 'PASSWORD',
                                  labelStyle: const TextStyle(
                                      color: Color(0xff888888), fontSize: 15)),
                            )),
                    GestureDetector(
                      onTap: onToggleShowPass,
                      child: Text(
                        _showPass ? 'HIDE' : 'SHOW',
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8)))),
                    onPressed: onSignInClicked,
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: SizedBox(
                  // height: 130,
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: 'NEW USER? ',
                                style: const TextStyle(color: Color(0xff888888)),
                                children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    },
                                  text: 'REGISTER',
                                  style: const TextStyle(color: Colors.blue)),
                            ])),
                        const Text(
                          'FORGET PASSWORD',
                          style: TextStyle(fontSize: 15, color: Colors.blue),
                        )
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSignInClicked() {
    setState(() {
      if (bloc.isValidInfo(_userController.text, _passController.text)) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    });
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  Widget goToHome(BuildContext context) {
    return HomePage();
  }
}

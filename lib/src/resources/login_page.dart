import 'package:authen_app/src/blocs/login_bloc.dart';
import 'package:authen_app/src/resources/dialog/loading_dialog.dart';
import 'package:authen_app/src/resources/dialog/msg_dialog.dart';
import 'package:authen_app/src/resources/login.dart';
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
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

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
              const SizedBox(
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
                    onPressed: onLoginClick,
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
                                text: 'New user? ',
                                style:
                                    const TextStyle(color: Color(0xff888888)),
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
                                  text: 'Register',
                                  style: const TextStyle(color: Colors.blue)),
                            ])),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 13),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          },
                          child: const Text('Forgot password'),
                        ),
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
    return const HomePage();
  }

  void onLoginClick() {
    String user = _userController.text;
    String pass = _passController.text;
    if (bloc.isValidInfo(_userController.text, _passController.text)) {
      LoadingDialog.showLoadingDialog(context, "Loading...");
      bloc.signIn(user, pass, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomePage()));
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Sign In", msg);
      });
    }
  }
}

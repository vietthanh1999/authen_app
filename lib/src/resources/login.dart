import 'package:authen_app/src/resources/home_page.dart';
import 'package:authen_app/src/resources/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var loading = false;

  void _loginWithInFaceBook() async {
    setState(() {
      loading = true;
    });

    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      final facebookAuthCredential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);

      // await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      await FirebaseFirestore.instance.collection('users').add({
        'email': userData['email'],
        'imageUrl': userData['picture']['data']['url'],
        'name': userData['name']
      });

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      var content = 'Firebase Auth Exception';
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  title: const Text('Login with Facebook failed'),
                  content: Text(content),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    )
                  ]));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void _loginWithInGoogle() async {
    setState(() {
      loading = true;
    });

    final googleSignIn = GoogleSignIn(scopes: ['email']);

    try {
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        setState(() {
          loading = false;
        });
        return;
      }

      final googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);
      await FirebaseFirestore.instance.collection('users').add({
        'email': googleSignInAccount.email,
        'imageUrl': googleSignInAccount.photoUrl,
        'name': googleSignInAccount.displayName,
      });

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      var content = 'Firebase Auth Exception';
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  title: const Text('Login with Facebook failed'),
                  content: Text(content),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    )
                  ]));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xfff9faf9),
        elevation: 0,
        centerTitle: true,
        title: const _LoginText('Login', 18, Colors.black),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _Button(
              color: Colors.black,
              isBorder: true,
              image: const AssetImage('assets/images/google.png'),
              text: 'Google',
              onPressed: () {
                _loginWithInGoogle();
              }),
          _Button(
              color: Colors.white,
              backgroundColor: const Color(0xff415ca3),
              image: const AssetImage('assets/images/facebook.png'),
              text: 'Facebook',
              onPressed: () {
                _loginWithInFaceBook();
              }),
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: _LoginText('or', 18, Colors.black),
          ),
          _Button(
              color: Colors.white,
              backgroundColor: const Color(0xffc64d36),
              image: const AssetImage('assets/images/email.png'),
              text: 'Email',
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              }),
        ],
      )),
    );
  }
}

class _Button extends StatelessWidget {
  final Color color;
  final ImageProvider image;
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final bool isBorder;

  const _Button({
    required this.color,
    required this.image,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.isBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 20.0,
        right: 20.0,
      ),
      child: Container(
        color: backgroundColor,
        child: GestureDetector(
          onTap: () {
            if (onPressed != null) {
              onPressed();
            }
          },
          child: Container(
            height: 55,
            decoration: BoxDecoration(border: !isBorder ? Border.all(color: backgroundColor) : Border.all(color: Colors.grey.shade200)),
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              const SizedBox(
                width: 5,
              ),
              Container(
                color: Colors.white,
                child: Image(
                  image: image,
                  width: 25,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(text, style: TextStyle(color: color, fontSize: 18)),
                  const SizedBox(
                    width: 35,
                  )
                ],
              ))
            ]),
          ),
        ),
      ),
    );
  }
}

class _LoginText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const _LoginText(this.text, this.fontSize, this.color);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: color, fontSize: fontSize));
  }
}

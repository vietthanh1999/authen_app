import 'package:authen_app/src/resources/LoginText.dart';
import 'package:authen_app/src/resources/home_page.dart';
import 'package:authen_app/src/resources/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var loading = false;

  void _LoginWithInFaceBook() async {
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

  void _LoginWithInGoogle() async {
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
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const LoginText('Login Social'),
          const SizedBox(
            height: 5,
          ),
          _Button(
              color: Colors.grey.shade600,
              image: const AssetImage('assets/images/email.png'),
              text: 'Email',
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              }),
          _Button(
              color: Colors.grey.shade600,
              image: const AssetImage('assets/images/facebook.png'),
              text: 'Facebook',
              onPressed: () {
                _LoginWithInFaceBook();
              }),
          _Button(
              color: Colors.grey.shade600,
              image: const AssetImage('assets/images/google.png'),
              text: 'Google',
              onPressed: () {
                _LoginWithInGoogle();
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

  _Button({
    required this.color,
    required this.image,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: GestureDetector(
        onTap: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        child: Container(
          height: 55,
          decoration: BoxDecoration(
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            const SizedBox(
              width: 5,
            ),
            Image(
              image: image,
              width: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}

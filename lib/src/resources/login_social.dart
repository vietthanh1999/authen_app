import 'package:flutter/material.dart';

class LoginSocial extends StatelessWidget {
  const LoginSocial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login social',
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          // constraints: const BoxConstraints.expand(),
          color: Colors.white,
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3)))),
                    child: Row(
                      children: const [
                        Icon(Icons.facebook_outlined, size: 38),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                            child: Text(
                              'Facebook',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3)))),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.apple,
                          size: 38,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                            child: Text(
                              'Google',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrangeAccent,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3)))),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.email,
                          size: 38,
                          color: Colors.white,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                            child: Text(
                              'Email',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ]),
        ));
  }
}

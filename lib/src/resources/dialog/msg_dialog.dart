import 'package:flutter/material.dart';

class MsgDialog {
  static void showMsgDialog(BuildContext context, String title, String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        // ignore: unnecessary_new
        builder: (context) => new AlertDialog(
              title: Text(title),
              content: Text(msg),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(MsgDialog());
                    },
                    child: const Text("OK"))
              ],
            ));
  }
}

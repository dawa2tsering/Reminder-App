// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomDialogue extends StatelessWidget {
  String? title;
  String? content;
  String? btnText1;
  String? btnText2;
  VoidCallback? onPressed1;
  VoidCallback? onPressed2;
  CustomDialogue(
      {Key? key,
      this.title,
      this.content,
      this.btnText1,
      this.btnText2,
      this.onPressed1,
      this.onPressed2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      content: Text(content!),
      actions: [
        TextButton(onPressed: onPressed1, child: Text(btnText1!)),
        TextButton(onPressed: onPressed2, child: Text(btnText2!)),
      ],
    );
  }
}

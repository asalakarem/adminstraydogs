import 'package:flutter/material.dart';

void navigateAndFinish(BuildContext context, Widget widget) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<Widget>(builder: (context) => widget),
      (route) {
        return false;
      },
    );

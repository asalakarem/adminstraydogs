import 'package:flutter/material.dart';

void navigateTo(BuildContext context, Widget widget) => Navigator.push(
    context,
    MaterialPageRoute<Widget>(builder: (context) => widget),
  );

void navigateAndFinish(BuildContext context, Widget widget) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<Widget>(builder: (context) => widget),
      (route) {
        return false;
      },
    );

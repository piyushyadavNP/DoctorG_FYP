import 'package:doctor/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AlertInfo {
  final String? message;
  AlertInfo({this.message});

  ScaffoldFeatureController showInfo(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message!),
    ));
  }
}

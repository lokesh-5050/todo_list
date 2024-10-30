import 'package:flutter/material.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/services/router/router_config.dart';

class Messenger {
  static void showMessage(String title, String description) {
    ScaffoldMessenger.of(rootNavigatorKey.currentContext!)
        .showSnackBar(SnackBar(
            content: Container(
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(rootNavigatorKey.currentContext!)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w400,color: whiteColor),
          )
        ],
      ),
    )));
  }
}

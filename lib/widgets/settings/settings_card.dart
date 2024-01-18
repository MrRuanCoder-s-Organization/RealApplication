import 'package:flutter/material.dart';

import '../../app/app_style.dart';

class SettingsCard extends StatelessWidget {
  final Widget child;
  const SettingsCard({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.withOpacity(0.2)
          : Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyle.radius8,
        side: BorderSide(
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppStyle.radius8,
        ),
        child: child,
      ),
    );
  }
}
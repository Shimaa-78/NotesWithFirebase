import 'package:flutter/material.dart';

import 'dialoge.dart';


Container CustomButton(String txt,BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: isDarkMode ? Color(0xff067E7A) : Color(0xff067E7A),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        txt,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

void showDeleteDialog(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (context) {
      return CustomDialog(onConfirm: onConfirm);
    },
  );
}


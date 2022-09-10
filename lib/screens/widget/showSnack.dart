import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin Helpers {
  // ignore: non_constant_identifier_names
  void ShowSnakBar(BuildContext context,
      {required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red.shade700 : Colors.blue.shade300,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        // padding: EdgeInsets.all(20),
        elevation: 10,
        // dismissDirection: DismissDirection.vertical,
        dismissDirection: DismissDirection.horizontal,
        action: SnackBarAction(
          label: 'Delete',
          onPressed: () {},
          textColor: Colors.white,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

snackBarMessenger({required BuildContext context,required Color color,required String message}){

  return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:  Padding(
            padding:const EdgeInsets.all(8.0),
            child: Text(message),
          ),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      );
}
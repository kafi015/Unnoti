import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context,String titel, [bool error = false])
{
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
          Text(titel,style: const TextStyle(fontSize: 18),),
        backgroundColor: error? Colors.red: Colors.green,
      ));
}
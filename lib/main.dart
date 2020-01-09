import 'package:flutter/material.dart';
import 'src/home.dart';
void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hintColor: Colors.amber ,
          primaryColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          )
      ),
    home: Home(),
  ));
}


import 'package:apilearning/example_four.dart';
import 'package:apilearning/example_three.dart';
import 'package:apilearning/example_two.dart';
import 'package:apilearning/login.dart';
import 'package:apilearning/new_app.dart';
import 'package:apilearning/signup.dart';
import 'package:apilearning/upload_image.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:NewsApp(

      ),
    );
  }
}





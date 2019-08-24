import 'package:flutter/material.dart';
import 'package:google_map/bottomsheet.dart';
import 'package:google_map/details.dart';
import 'package:google_map/freeslot.dart';
import 'package:google_map/homepage.dart';
import 'package:google_map/post.dart';
import 'package:google_map/registrationform.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
     
        primarySwatch: Colors.blue,
      ),
      home: RegistrationForm(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:furnitui/screens/home.dart';
import 'package:furnitui/screens/notifications.dart';
import 'package:furnitui/screens/order_history.dart';
import 'package:furnitui/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
  primaryColor: MyColors.primaryColor,
  textTheme: GoogleFonts.poppinsTextTheme(),
),

      title: 'Flutter Demo',
      home:  Notifications(),
    );
  }
}
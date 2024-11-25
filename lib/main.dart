import 'package:flutter/material.dart';
import 'package:furnitui/providers/category.dart';
import 'package:furnitui/providers/product.dart';
import 'package:furnitui/screens/home.dart';
import 'package:furnitui/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: MyColors.primaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      title: 'Furnit UI',
      home: const HomeScreen(),
    );
  }
}

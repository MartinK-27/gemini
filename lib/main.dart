import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'const.dart';
import 'presentation/screens/home_page.dart';


void main() {
  Gemini.init(apiKey: GEMINI_API_KEY);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      home: HomePage(),
    );
  }
}

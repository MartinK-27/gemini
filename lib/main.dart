// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini/core/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String GEMINI_API_KEY = "AIzaSyC3LSaAcKZbyyZDFPlvQ0A8K06u5IOPpWQ";

void main() {
  Gemini.init(apiKey: GEMINI_API_KEY);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
     
      routerConfig: appRouter,
    );
  }
}

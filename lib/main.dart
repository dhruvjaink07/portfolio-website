import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/portfolio_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Developer Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0A192F),
        scaffoldBackgroundColor: const Color(0xFF0A192F),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF64FFDA),
          secondary: Color(0xFF64FFDA),
          surface: Color(0xFF172A45),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Color(0xFFCCD6F6)),
          displayMedium: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFFCCD6F6)),
          displaySmall: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFCCD6F6)),
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF8892B0)),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF8892B0)),
        ),
      ),
      home: PortfolioScreen(),
    );
  }
}

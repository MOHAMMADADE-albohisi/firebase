import 'package:firebase/screens/app/home_screen.dart';
import 'package:firebase/screens/auth/login_screen.dart';
import 'package:firebase/screens/auth/register_screen.dart';
import 'package:firebase/screens/core/lunch_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ),
      initialRoute: '/lunch_screen',
      routes: {
        '/lunch_screen': (context) => const LunchScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/register_screen': (context) => const RegesterScreen(),
        '/home_screen': (context) => const HomeScreen(),
      },
    );
  }
}

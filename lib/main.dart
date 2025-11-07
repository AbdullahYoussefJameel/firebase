import 'package:firebase/auth/homepage.dart';
import 'package:firebase/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/auth/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // عنوان المحاكي صحيح للاتصال من محاكي Android
  //await FirebaseAuth.instance.useAuthEmulator('10.0.2.2', 9099);

  runApp(const MyApp());
}

// ----------------------------------------------------
// 1. تحويل الكلاس إلى StatefulWidget
// ----------------------------------------------------
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ----------------------------------------------------
  // 2. إضافة دالة initState إلى كائن State
  // ----------------------------------------------------
  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('================User is currently signed out!');
      } else {
        print('======User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      routes: {
        "login": (context) => const Login(),
        "signup": (context) => const signup(),
        "homepage": (context) => const Homepage()
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Login(),
    );
  }
}

import 'package:firebase/auth/homepage.dart';
import 'package:firebase/auth/signup.dart';
import 'package:firebase/categores/add.dart';
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
      theme: ThemeData(appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[100],
        titleTextStyle: TextStyle(color: Colors.orange ,fontSize: 17,fontWeight: FontWeight.bold),
        iconTheme:IconThemeData(
          color: Colors.orange, 
        ) ,

      )),
      debugShowCheckedModeBanner: false,
home: (FirebaseAuth.instance.currentUser != null &&
       FirebaseAuth.instance.currentUser!.emailVerified)
    ? Homepage()
    : Login(),
      routes: {
        "login": (context) => const Login(),
        "signup": (context) => const Signup(),
        "homepage": (context) => const Homepage(),
        "addcat":(context)=> addcat(),
      },
    );
  }
}
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase/components/custombutten.dart';
import 'package:firebase/components/customlogo.dart';
import 'package:firebase/components/textformfeldcos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();

  final GlobalKey<FormState> formStat = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: formStat,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Customlogo(),
                  const SizedBox(height: 20),
                  const Text(
                    "Signup",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    "Create an account to continue using the app",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 20),
                  const Text("Username",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  Textformfeldcos(
                    hintText: "Enter your username",
                    mycontroller: username,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Can't be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text("Email",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  Textformfeldcos(
                    hintText: "Enter your email",
                    mycontroller: email,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Can't be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text("Password",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                  Textformfeldcos(
                    hintText: "Enter your password",
                    mycontroller: password,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Can't be empty";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
             const SizedBox(height: 20),
            CustomButton(

              //===============================================
              title: "signup",
              onPressed: () async {
                if (formStat.currentState!.validate()) {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text.trim(),
                      password: password.text.trim(),
                    );

                    if (mounted) {
                     await FirebaseAuth.instance.currentUser!.sendEmailVerification();
                      Navigator.of(context)
                          .pushReplacementNamed("login");
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.bottomSlide,
                        title: 'Weak Password',
                        desc: 'Please choose a stronger password.',
                        btnOkOnPress: () {},
                      ).show();
                    } else if (e.code == 'email-already-in-use') {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.bottomSlide,
                        title: 'Email in use',
                        desc:
                            'An account already exists for that email. Try another.',
                        btnOkOnPress: () {},
                      ).show();
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              },
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("login");
              },
              child: Center(
                child: Text.rich(
                  TextSpan(children: [
                    const TextSpan(text: "Have an account? "),
                    TextSpan(
                      text: "Login!",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w600),
                    )
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//CustomButton(title: "signup",onPressed:  ()async{
//         if(FormStat.currentState!.validate()){
//                   try {
//   final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//     email: email.text,
//     password: password.text,
//   );
//      Navigator.of(context).pushReplacementNamed("homepage");

// } on FirebaseAuthException catch (e) {
//   if (e.code == 'weak-password') {
//      AnimatedButton(
//                   text: 'Info Reverse Dialog Without buttons',
//                   pressEvent: () {
//                     AwesomeDialog(
//                       context: context,
//                       dialogType: DialogType.info,
//                       headerAnimationLoop: true,
//                       animType: AnimType.bottomSlide,
//                       title: 'week password',
//                       reverseBtnOrder: true,
//                       btnOkOnPress: () {},
//                       btnCancelOnPress: () {},
//                       desc:
//                           'make anthore password,',
//                     ).show();
//                   },
//                 );
//     print('The password provided is too weak.');
//   } else if (e.code == 'email-already-in-use') {
//      AnimatedButton(
//                   text: 'Info Reverse Dialog Without buttons',
//                   pressEvent: () {
//                     AwesomeDialog(
//                       context: context,
//                       dialogType: DialogType.info,
//                       headerAnimationLoop: true,
//                       animType: AnimType.bottomSlide,
//                       title: 'that email used',
//                       reverseBtnOrder: true,
//                       btnOkOnPress: () {},
//                       btnCancelOnPress: () {},
//                       desc:
//                           'try anthore email,',
//                     ).show();
//                   },
//                 );
//     print('The account already exists for that email.');
//   }
// } catch (e) {
//   print(e);
// }
      

//   }}),
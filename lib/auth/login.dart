import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase/components/custombutten.dart';
import 'package:firebase/components/customlogo.dart';
import 'package:firebase/components/textformfeldcos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});



  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
TextEditingController password=TextEditingController();
TextEditingController email=TextEditingController();
  GlobalKey<FormState> FormStat =GlobalKey<FormState>();
  bool looding=false;


Future signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  if (googleUser == null) {
    // المستخدم ألغى تسجيل الدخول
    return null;
  }

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    idToken: googleAuth.idToken,
    accessToken: googleAuth.accessToken,
  );

  // Once signed in, return the UserCredential
   await FirebaseAuth.instance.signInWithCredential(credential);
  Navigator.of(context).pushReplacementNamed("homepage");
}

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:looding ==true ?Center(child: CircularProgressIndicator(),) : Container(
          padding: EdgeInsets.all(10),
        child: ListView(
          
          children: [
          Form(
            key: FormStat,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 30),
                Customlogo(),
              Container(
                height: 20,
              ),
              Text("login",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
              
              Text("logon to continue using the app",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300)),
              Container(
                height: 20,
              ),
              Text("login",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500) ,),
              Container(height: 10,),
              Textformfeldcos(hintText: "enter your email", mycontroller: email,validator: (val) {
  if (val == null || val.isEmpty) {
    return "Can't be empty";
  }
  return null; // ضروري لإرجاع null إذا لم يوجد خطأ
},
),
              Container(height: 15,),
              Text("password",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500) ,),
              Container(height: 10,),
                     Textformfeldcos(hintText: "enter your password", mycontroller: password,validator: (val) {
  if (val == null || val.isEmpty) {
    return "Can't be empty";
  }
  return null; // ضروري لإرجاع null إذا لم يوجد خطأ
},
),
              Container(height: 15,),
           InkWell(
  onTap: () async {
    // ✅ Check if email field is empty
    if (email.text.trim().isEmpty) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        title: 'Check your email',
        desc: 'You need to enter your email address.',
        btnOkOnPress: () {},
      ).show();
      return;
    }

    try {
      // ✅ Try sending the password reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email.text.trim(),
      );

      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        title: 'Check your email',
        desc: 'We’ve sent a password reset link to your email.',
        btnOkOnPress: () {},
      ).show();
    } on FirebaseAuthException catch (e) {
      // ✅ Handle specific Firebase errors
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is invalid.';
      } else {
        message = 'Something went wrong. Please try again.';
      }

      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Error',
        desc: message,
        btnOkOnPress: () {},
      ).show();
    } catch (e) {
      // ✅ Handle unexpected errors
      print('Error sending password reset email: $e');
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Error',
        desc: 'An unexpected error occurred. Please try again.',
        btnOkOnPress: () {},
      ).show();
    }
  },
  child: Container(
    margin: const EdgeInsets.only(top: 10, bottom: 20),
    alignment: Alignment.bottomRight,
    child: const Text(
      "Forget password!",
      textAlign: TextAlign.right,
      
    ),
  ),
)

              
                     
            ],
                    ),
          ),
 CustomButton(
  title: "login",
  onPressed: () async {
    if (FormStat.currentState!.validate()){
looding= true;
setState(() {
  
});
  //  tr y {
  //     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: email.text,
  //       password: password.text,
  //     );

  //     // ✅ Only navigate if login succeeds
  //     Navigator.of(context).pushReplacementNamed("homepage");

  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       AwesomeDialog(
  //         context: context,
  //         dialogType: DialogType.info,
  //          headerAnimationLoop: true,
  //          animType: AnimType.bottomSlide,
  //         title: 'User not found',
  //         desc: 'No user found for that email.',
          
  //       ).show();
  //       print('No user found for that email.');
        
  //     } else if (e.code == 'wrong-password') {
  //       AwesomeDialog(
  //         context: context,
  //       dialogType: DialogType.info,
  //        headerAnimationLoop: true,
  //        animType: AnimType.bottomSlide,
  //         title: 'Wrong password',
  //         desc: 'Wrong password provided for that user.',
          
  //       ).show();
  //       print('=========================Wrong password provided for that user.');
        
  //     }
  //   }
  try {
  print("Attempting login...");
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email.text.trim(),
    password: password.text.trim(),
    
  );
  looding =false;
  setState(() {
    
  });
  print("✅ Login succeeded!");
  if (credential.user!.emailVerified){
    Navigator.of(context).pushReplacementNamed("homepage");
  }else{
     looding =false;
  setState(() {
    
  });
   //await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    AwesomeDialog(
    context: context,
    title: 'Error',
    desc:"please verified your email",
  ).show();

  }
} on FirebaseAuthException catch (e) {
   looding =false;
  setState(() {
    
  });
  print("FirebaseAuthException: ${e.code}");
  print("Message: ${e.message}");
  AwesomeDialog(
    context: context,
    title: 'Auth Error',
    desc: e.message ?? 'Unknown FirebaseAuth error.',
  ).show();
} catch (e) {
  print("🔥 Other Exception: $e");
  AwesomeDialog(
    context: context,
    title: 'Error',
    desc: e.toString(),
  ).show();
}
    }else{
      print("not valed");
    }

  },

),

          Container(height: 20,),
          // ignore: prefer_const_constructors
          Text("or login",textAlign: TextAlign.center,),
           MaterialButton(height: 60,
        color: const Color.fromARGB(255, 204, 28, 28),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: ()async{
            signInWithGoogle() ;
          },child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("login with google  " ),Image.asset('images/gogle.webp',width: 25,)],),),
          Container(height: 20,),
          InkWell(
            onTap: (){
              Navigator.of(context).pushReplacementNamed("signup");
            },
            child: Center(
              child: Text.rich(TextSpan(children:[
                TextSpan(text: "dont have an accuont ?  "),
                TextSpan(text: "register! ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600
                ))
              ] )),
            ),
          )
        ],
      )            
           ),
    );
  }
}
import 'package:firebase/components/custombutten.dart';
import 'package:firebase/components/customlogo.dart';
import 'package:firebase/components/textformfeldcos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
TextEditingController password=TextEditingController();
TextEditingController email=TextEditingController();
TextEditingController username=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
          padding: EdgeInsets.all(10),
        child: ListView(
          
          children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 30),
              Customlogo(),
            Container(
              height: 20,
            ),
            Text("signup",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
            
            Text("logon to continue using the app",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300)),
            Container(
              height: 20,
            ),
            Text("username",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500) ,),
            Container(height: 10,),
             Textformfeldcos(hintText: "enter your username", mycontroller: username),
            Container(height: 10,),
            Text("email",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500) ,),
            Container(height: 10,),
                        Textformfeldcos(hintText: "enter your email", mycontroller: email),

            Container(height: 15,),
                        Text("password",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500) ,),

            Textformfeldcos(hintText: "enter your password", mycontroller: password),

            Container(
              margin: EdgeInsets.only(top: 10,bottom: 20),
              alignment: Alignment.bottomRight,
              child: Text(textAlign: TextAlign.right,
                "forget password !",style: TextStyle(fontSize: 14),),
            ),
            
         
          ],
        ),
      CustomButton(title: "signup",onPressed:  ()async{
        try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email.text,
    password: password.text,
  );
     Navigator.of(context).pushReplacementNamed("homepage");

} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
      }),
          Container(height: 20,),
           
          Container(height: 20,),
          InkWell(
            onTap: (){
              Navigator.of(context).pushReplacementNamed("login"); 
            },
            child: Center(
              child: Text.rich(TextSpan(children:[
                TextSpan(text: " have an accuont ?  "),
                TextSpan(text: "login! ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600
                ))
              ] )),
            ),
          )
        ],
      )
            
          )
          
            
      
    );
  }
}
import 'package:firebase/components/custombutten.dart';
import 'package:firebase/components/customlogo.dart';
import 'package:firebase/components/textformfeldcos.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
TextEditingController password=TextEditingController();
TextEditingController email=TextEditingController();
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
            Text("login",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
            
            Text("logon to continue using the app",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300)),
            Container(
              height: 20,
            ),
            Text("login",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500) ,),
            Container(height: 10,),
            Textformfeldcos(hintText: "enter your email", mycontroller: email),
            Container(height: 15,),
            Text("password",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500) ,),
            Container(height: 10,),
         Textformfeldcos(hintText: "enter your password", mycontroller: password),
            Container(height: 15,),
            Container(
              margin: EdgeInsets.only(top: 10,bottom: 20),
              alignment: Alignment.bottomRight,
              // ignore: prefer_const_constructors
              child: Text(textAlign: TextAlign.right,
                "forget password !",style: TextStyle(fontSize: 14),),
            ),
            
         
          ],
        ),
      CustomButton(title: "login",onPressed:  (){}),
          Container(height: 20,),
          // ignore: prefer_const_constructors
          Text("or login",textAlign: TextAlign.center,),
           MaterialButton(height: 60,
        color: const Color.fromARGB(255, 204, 28, 28),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: (){},child: Row(
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
            
          )
          
            
      
    );
  }
}
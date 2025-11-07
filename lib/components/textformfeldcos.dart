import 'package:flutter/material.dart';

class Textformfeldcos extends StatelessWidget {
  const Textformfeldcos({super.key, required this.hintText, required this.mycontroller, });
final String hintText;

  final TextEditingController mycontroller;
  @override
  Widget build(BuildContext context) {
    return   TextFormField(
          controller: mycontroller, 
              decoration: InputDecoration(
                hintText: hintText,hintStyle:TextStyle(fontSize: 14) ,
                contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal: 20),
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder:   OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey),
                )
              ),
            );
  }
}
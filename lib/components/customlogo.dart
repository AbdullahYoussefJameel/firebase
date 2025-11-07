import 'package:flutter/material.dart';

class Customlogo extends StatelessWidget {
  const Customlogo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
                child: Container(
                  padding:EdgeInsets.all(20),
                height: 80,
                width: 80,
                          
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30)
                ),
                         child:    Image.asset("images/absa.png",width: 90 ,height:90 ,)
                
                            ),
              );
  }
}
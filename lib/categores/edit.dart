import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/components/costemtextform.dart';
import 'package:firebase/components/custombutten.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class editcat extends StatefulWidget {
  final String  docid;
  final String oldname;
  const editcat({super.key, required this.docid, required this.oldname});

  @override
  State<editcat> createState() => _editcatState();
}

class _editcatState extends State<editcat> {
  TextEditingController name = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
      bool looding =false;

  Future<void> editcaegory() async {
    if (formKey.currentState!.validate()) {
      try {
        looding=true;
        setState(() {
          
        });
       await categories.doc(widget.docid).update({
        "name": name.text.trim()}
       );
        looding=false;
      Navigator.of(context).pushReplacementNamed("homepage");
        print("=================Category Added");
        name.clear();
      } catch (error) {
        looding=false;
        setState(() {
          
        });
        print("Failed to add category: $error");
      }
    }
  }
@override
  void initState() {
    super.initState();
    name.text=widget.oldname;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Category")),
      body: Form(
        key: formKey,
        child:looding ?Center(child: CircularProgressIndicator(),): Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Costemtextform(
                hintText: "Enter Name",
                mycontroller: name,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return "Can't be empty";
                  }
                  return null;
                },
              ),
            ),
            CustomButton(
              title: "edit",
              onPressed: (){
                editcaegory() ;
              },
            ),
          ],
        ),
      ),
    );
  }
}

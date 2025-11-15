import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/components/costemtextform.dart';
import 'package:firebase/components/custombutten.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class addcat extends StatefulWidget {
  const addcat({super.key});

  @override
  State<addcat> createState() => _addcatState();
}

class _addcatState extends State<addcat> {
  TextEditingController name = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
      bool looding =false;

  Future<void> addCategory() async {
    if (formKey.currentState!.validate()) {
      try {
        looding=true;
        setState(() {
          
        });
        await categories.add({
          "name": name.text.trim(),
          "id" :FirebaseAuth.instance.currentUser!.uid,
        });
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
              title: "Add",
              onPressed: addCategory,
            ),
          ],
        ),
      ),
    );
  }
}

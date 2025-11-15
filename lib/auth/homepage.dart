import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/categores/edit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List data=[];

bool looling =true;

 getdata() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('categories').where("id", isEqualTo:FirebaseAuth.instance.currentUser!.uid )
      .get();
    data.addAll(querySnapshot.docs);
    //await Future.delayed(Duration(seconds: 2));
    looling=false;

  setState(() {
        print("عدد العناصر: ${data.length}");
  });
}

 
  @override
  @override
  void initState() {
    getdata();
    super.initState();
    
  }
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
        Navigator.of(context).pushNamed("addcat");
        //  Navigator.of(context).pushNamedAndRemoveUntil("addcat",  (Route<dynamic> route) => false);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("homepage"),
        actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
            //  await googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed("login");
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body:looling == true ? Center(child: CircularProgressIndicator()) : GridView.builder(
        itemCount:data.length ,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 150,
        ),
        itemBuilder: (context,i){

return InkWell(
  onLongPress: () {
     AwesomeDialog(
    context: context,
    title: 'Error',
    desc: 'do you wont to deleted or edite',
    btnCancelText: "deleted",
    btnOkText: "edite",
    btnOkOnPress: () async{
      
       await FirebaseFirestore.instance
      .collection('categories').doc(data[i].id).delete();
      Navigator.of(context).pushReplacementNamed("homepage");
    },
    btnCancelOnPress: ()async {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>editcat(docid: data[i].id, oldname: data[i]['name'])));
      
    },
  ).show();
  },
  child: Card(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Image.asset(
                      "images/abc.jpg",
                      height: 100,
                    ),
                    Text("${data[i]['name']}"),
                  ],
                ),
              ),
            ),
);




        },
 
          
        
      ),
    );
  }
}

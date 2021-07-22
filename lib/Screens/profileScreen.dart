import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:we_meet/variables.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName;
  bool dataIsThere = false;

  TextEditingController usernameController = TextEditingController();
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    DocumentSnapshot userdoc =
        await userCollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      userName = userdoc.data()['username'];
      dataIsThere = true;
    });
  }

  editProfile() async {
    await userCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({'username': usernameController.text});
    setState(() {
      userName = usernameController.text;
    });
    Navigator.pop(context);
  }

  openProfileDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 200,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      style: myStyle(18, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Update Username",
                        labelStyle: myStyle(16, color: Colors.grey),
                      ),
                      controller: usernameController,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      editProfile();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: GradientColors.cherry),
                      ),
                      child: Center(
                        child: Text(
                          "Update",
                          style: myStyle(17, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[250],
      body: dataIsThere == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: GradientColors.facebookMessenger),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2 - 64,
                      top: MediaQuery.of(context).size.height / 3.1,
                    ),
                    child: CircleAvatar(
                      radius: 64,
                      backgroundImage: AssetImage('Images/profile.png'),
                    )),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300,
                      ),
                      Text(
                        userName,
                        style: myStyle(
                          40,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          openProfileDialog();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: GradientColors.coolBlues),
                          ),
                          child: Center(
                            child: Text(
                              "Edit Profile",
                              style: myStyle(17, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient:
                                LinearGradient(colors: GradientColors.cherry),
                          ),
                          child: Center(
                            child: Text(
                              "Sign Out",
                              style: myStyle(17, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

import '../variables.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: GradientColors.blue)),
            child: Center(
              child: Image.asset(
                'Images/logo.png',
                height: 100,
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.6,
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: const Offset(0, 3))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: TextField(
                        controller: emailController,
                        style: myStyle(18, color: Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "email id",
                          prefixIcon: Icon(Icons.email),
                          hintStyle: myStyle(20,
                              color: Colors.grey, fw: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: myStyle(18, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          hintStyle: myStyle(20,
                              color: Colors.grey, fw: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: TextField(
                        controller: usernameController,
                        style: myStyle(18, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: Icon(Icons.person),
                          hintStyle: myStyle(20,
                              color: Colors.grey, fw: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        try {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((signedUser) {
                            userCollection.doc(signedUser.user.uid).set({
                              'username': usernameController.text,
                              'email': emailController.text,
                              'password': passwordController.text,
                              'uid': signedUser.user.uid
                            });
                          });
                        } catch (e) {
                          print(e);
                          SnackBar snackbar = SnackBar(
                              content: Text(
                            e.toString(),
                            style: myStyle(20),
                          ));
                          Scaffold.of(context).showSnackBar(snackbar);
                        }
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 60,
                        decoration: BoxDecoration(
                            gradient:
                                LinearGradient(colors: GradientColors.pink),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: myStyle(25, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

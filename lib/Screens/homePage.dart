import 'package:flutter/material.dart';
import 'package:we_meet/Screens/profileScreen.dart';
import 'package:we_meet/Screens/videoConferenceScreen.dart';
import 'package:we_meet/variables.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pageOptions = [VideoConferenceScreen(), ProfileScreen()];
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        selectedLabelStyle: myStyle(17, color: Colors.blue),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: myStyle(17, color: Colors.black),
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        currentIndex: page,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_call,
              size: 32,
            ),
            title: Text("Video call"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 32,
            ),
            title: Text("Profile"),
          )
        ],
      ),
      body: pageOptions[page],
    );
  }
}

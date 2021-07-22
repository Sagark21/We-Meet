import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../variables.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController nameController = TextEditingController();
  bool isVideoOff = true;
  bool isAudioMuted = true;
  String userName;
  TextEditingController roomController = TextEditingController();

  joinMeeting() async {
    FeatureFlag featureFlags = FeatureFlag();
    try {
      featureFlags.welcomePageEnabled = false;

      if (Platform.isAndroid) {
        featureFlags.callIntegrationEnabled = false;
      } else if (Platform.isIOS) {
        featureFlags.pipEnabled = false;
      }
      var options = JitsiMeetingOptions()
        ..room = roomController.text
        ..userDisplayName =
            nameController.text == "" ? userName : nameController.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoOff
        ..featureFlag = featureFlags;
      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print("Error:$e");
    }
  }

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Text(
                "Room Code",
                style: myStyle(20),
              ),
              SizedBox(
                height: 20,
              ),
              PinCodeTextField(
                controller: roomController,
                appContext: context,
                length: 6,
                onChanged: (value) {},
                autoDisposeControllers: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(shape: PinCodeFieldShape.underline),
                animationDuration: Duration(milliseconds: 300),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: nameController,
                style: myStyle(20),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name or Leave if you want your Username",
                  labelStyle: myStyle(15),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CheckboxListTile(
                value: isVideoOff,
                onChanged: (value) {
                  setState(() {
                    isVideoOff = value;
                  });
                },
                title: Text(
                  "Camera off",
                  style: myStyle(18, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CheckboxListTile(
                value: isAudioMuted,
                onChanged: (value) {
                  setState(() {
                    isAudioMuted = value;
                  });
                },
                title: Text(
                  "Audio Muted",
                  style: myStyle(18, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "You can change the settings in the meeting",
                style: myStyle(15),
                textAlign: TextAlign.center,
              ),
              Divider(
                height: 48,
                thickness: 2.0,
              ),
              InkWell(
                onTap: () {
                  joinMeeting();
                },
                child: Container(
                  width: double.maxFinite,
                  height: 64,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: GradientColors.facebookMessenger)),
                  child: Center(
                    child: Text(
                      "Join Meeting",
                      style: myStyle(20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

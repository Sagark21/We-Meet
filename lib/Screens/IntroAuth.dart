import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:we_meet/variables.dart';
import 'package:we_meet/authentication/NavigatorAuthscreen.dart';

import '../variables.dart';

class IntroAuthScreen extends StatefulWidget {
  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
            titleWidget: TypewriterAnimatedTextKit(
              text: ['We Meet'],
              textStyle: TextStyle(
                fontSize: 45.0,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w900,
              ),
            ),
            body: "Welcome to We Meet App, the best Video Conferencing app",
            image: Center(
              child: Image.asset(
                'Images/welcome.png',
                height: 175,
              ),
            ),
            decoration: PageDecoration(
              bodyTextStyle: myStyle(20, color: Colors.black),
              titleTextStyle: myStyle(20, color: Colors.black),
            )),
        PageViewModel(
            title: "Join or Start Meetings",
            body: "Easy to use interface, join or Start meetings in time",
            image: Center(
              child: Image.asset(
                'Images/conference.png',
                height: 175,
              ),
            ),
            decoration: PageDecoration(
              bodyTextStyle: myStyle(20, color: Colors.black),
              titleTextStyle: myStyle(20, color: Colors.black),
            )),
        PageViewModel(
            title: "Security",
            body: "Your Security is important to us, It is secure and reliable",
            image: Center(
              child: Image.asset(
                'Images/secure.jpg',
                height: 175,
              ),
            ),
            decoration: PageDecoration(
              bodyTextStyle: myStyle(20, color: Colors.black),
              titleTextStyle: myStyle(20, color: Colors.black),
            ))
      ],
      onDone: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavigatorAuthScreen()));
      },
      onSkip: () {},
      showSkipButton: true,
      skip: const Icon(
        Icons.skip_next,
        size: 45,
      ),
      next: const Icon(
        Icons.arrow_forward_ios,
      ),
      done: Text(
        "Done",
        style: myStyle(20, color: Colors.black),
      ),
    );
  }
}

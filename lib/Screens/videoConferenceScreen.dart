import 'package:flutter/material.dart';
import 'package:we_meet/variables.dart';
import 'package:we_meet/videoConference/createMeeting.dart';
import 'package:we_meet/videoConference/joinMeeting.dart';

class VideoConferenceScreen extends StatefulWidget {
  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  buildTAb(String name) {
    return Container(
      width: 150,
      height: 50,
      child: Card(
        child: Center(
          child: Text(
            name,
            style: myStyle(15, color: Colors.black, fw: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: Text(
          "We Meet",
          style: myStyle(20, color: Colors.white, fw: FontWeight.w700),
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: [buildTAb("Join Meeting"), buildTAb("Create Meeting")],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          JoinMeeting(),
          CreateMeeting(),
        ],
      ),
    );
  }
}

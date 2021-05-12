import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile-screen.dart';


class ProfileOther extends StatefulWidget {
  @override
  _ProfileOtherState createState() => _ProfileOtherState();
}

class _ProfileOtherState extends State<ProfileOther> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("USER INFO", style: GoogleFonts.openSans(fontWeight: FontWeight.bold,  ) , ),),
      body: ProfileScreen(isMe: false),
    );
  }
}
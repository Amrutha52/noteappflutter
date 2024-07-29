import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/animationConstants.dart';
import '../../utils/constants/colorConstants.dart';
import 'package:lottie/lottie.dart';

import '../note_screen/NoteScreen.dart';

class Splashscreen extends StatefulWidget
{
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
{
  @override
  void initState() {
    Future.delayed(Duration(seconds: 10))
        .then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotesScreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: colorConstants.mainBlack,
      body: Center(
        child: Lottie.asset(animationConstants.LOGO_ANIMATION),
      ),
    );
  }
}
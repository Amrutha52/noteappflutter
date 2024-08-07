import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/utils/constants/colorConstants.dart';

class NoteDetailsScreen extends StatefulWidget
{
  const NoteDetailsScreen({super.key,
    required this.currentNoteDesc,
    required this.title,
    required this.date,
    required this.noteColor});
  final String currentNoteDesc;
  final String title;
  final String date;
  final Color noteColor;

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState(currentNoteDesc,
      title,
      date,
      noteColor);
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen>
{
  _NoteDetailsScreenState(this.currentNoteDesc,
      this.title,
      this.date,
      this.noteColor
      );
  String currentNoteDesc, title, date;
  Color noteColor;

  @override
  Widget build(BuildContext context)
  {
    var screenWidth = MediaQuery.sizeOf(context).width; // To determine width
    var screenHeight = MediaQuery.sizeOf(context).height; // To determine height

    return Scaffold(
      backgroundColor: noteColor,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(width: 10, color: colorConstants.mainWhite),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),
            Text(
              currentNoteDesc,
              maxLines: 1000,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 10,),
            // Align widget is used for Text alignment purpose
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                date,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      )
    );
  }
}

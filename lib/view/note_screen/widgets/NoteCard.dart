import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/utils/constants/colorConstants.dart';

import '../../../controller/NoteScreenController.dart';

class NoteCard extends StatelessWidget
{
  const NoteCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.colorIndex,
    this.onDeletePressed,
    this.onEditPressed});

  final String title;
  final String description;
  final String date;
  final int colorIndex;
  final void Function()? onDeletePressed;
  final void Function()? onEditPressed;



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: NoteScreenController.colorList[colorIndex],
          borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Row(
                children: [
                  InkWell(onTap:onEditPressed , //onEditPressed
                      child: Icon(Icons.edit)),
                  SizedBox(width: 15),
                  InkWell(onTap: onDeletePressed,// onDeletePressed
                      child: Icon(Icons.delete))
                ],
              ),
            ],
          ),
          SizedBox(height: 10,),
          Text(description),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(date),
              SizedBox(width: 20),
              InkWell(
                  onTap: ()
                  {
                    //Share.share("$title\n$des");

                  },
                  child: Icon(Icons.share))
            ],
          )
        ],
      ),
    );
  }
}
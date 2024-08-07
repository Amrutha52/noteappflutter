import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/utils/constants/imageConstants.dart';
import 'package:share_plus/share_plus.dart';

class NoteCard extends StatelessWidget {
  const NoteCard(
      {super.key,
        this.onDelete,
        required this.title,
        required this.desc,
        required this.date,
        this.onEdit,
        required this.noteColor});
  final void Function()? onDelete; // cardine akathe ninne deletene listileke konde varan
  final void Function()? onEdit;
  final String title;
  final String desc;
  final String date;
  final Color noteColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        // image: DecorationImage(image: AssetImage(imageConstants.CARD_BG_PNG,
        // ),
        // fit: BoxFit.cover
        // ),
        color: noteColor, // notecardil kittunna colorine use cheyanu
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              // For Editing
              IconButton(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit, color: Colors.black)),
              // For Deleting
              IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete, color: Colors.black)),
            ],
          ),
          Text(
            desc,
            maxLines: 4,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.normal),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                date,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              // For Sharing
              IconButton(
                  onPressed: () {
                    Share.share("$title \n$desc \n$date"); // Separate data onnum kittenda aavashyam illa athondane evide viliche..
                  },
                  icon: Icon(Icons.share, color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }
}
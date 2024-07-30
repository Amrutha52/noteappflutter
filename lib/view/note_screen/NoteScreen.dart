
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/dummyDB.dart';
import 'package:noteapp/view/note_screen/widgets/NoteCard.dart';


class NotesScreen extends StatefulWidget
{
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int selectedColorIndex = 0; //currently selected color index kittaan
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey.shade300,
            onPressed: () {
              titleController.clear();  // oro thavaneyum aa oru bottom sheet varune munne data clear aavum. To clear controllers before opening the bottom sheet again..
              descController.clear();
              dateController.clear();
              selectedColorIndex = 0;
              _customBottomSheet(context); //isEdit false aayitulla BottomSheetine call cheyum,
            },
            child: Icon(Icons.add),
          ),
          body: ListView.separated(
              padding: EdgeInsets.all(15),
              itemBuilder: (context, index) => NoteCard(
                noteColor: DummyDB
                    .noteColors[DummyDB.notesList[index]["colorIndex"]], // DummyDB.notesList[index]["colorIndex"] store cheytha data edukan vendiyulla code
                date: DummyDB.notesList[index]["date"],
                desc: DummyDB.notesList[index]["desc"],
                title: DummyDB.notesList[index]["title"],
                // for deletion
                onDelete: () {
                  DummyDB.notesList.removeAt(index);
                  setState(() {});
                },
                // for editing
                onEdit: () {
                  titleController.text = DummyDB.notesList[index]["title"]; // UI il kannikunna dataye controlleril kanikunnu
                  dateController.text = DummyDB.notesList[index]["date"];
                  descController.text = DummyDB.notesList[index]["desc"];
                  selectedColorIndex = DummyDB.notesList[index]["colorIndex"];
                  // titleController = TextEditingController(
                  //     text: DummyDb.notesList[index]["title"]); // Another method
                  _customBottomSheet(context,
                      isEdit: true, itemIndex: index); // Edit varumbol isEdit true aayitulla BottomSheetine call cheyum,
                },
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              itemCount: DummyDB.notesList.length)),
    );
  }

  Future<dynamic> _customBottomSheet(BuildContext context,
      {bool isEdit = false, int? itemIndex}) { // IsBool edit false aaki koduthu, add cheyumbol false aane, data add cheythe kazhinja true aaki kodukum, itemIndex edit aanenkil venam illenkil venda
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom), // MediaQuery veche kannunna section vare padding konde vara
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText: "Title",
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: descController,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: "Description",
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(
                        hintText: "Date",
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(height: 20),
                  //build color section
                  StatefulBuilder( // Bottom Sheetne state update aavan, statefulBuilder veche wrap cheyyunu.
                    builder: (context, setColorState) => Row(
                      children: List.generate(
                        DummyDB.noteColors.length,
                            (index) => Expanded(
                          child: InkWell(
                            onTap: () {
                              selectedColorIndex = index; // click cheyunna indexine pass cheythe kodakanu.
                              setColorState(
                                    () {},
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              height: 50,
                              decoration: BoxDecoration(
                                  border: selectedColorIndex == index // Indexine anusariche border kanikanam
                                      ? Border.all(width: 3)
                                      : null, // Border null accept cheyum
                                  color: DummyDB.noteColors[index],
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (isEdit == true) {
                              DummyDB.notesList[itemIndex!] = {  // item indexileke puthiya mapine add cheyanam, epo controllerileke ulla values aa particular indexileke add aavum.
                                "title": titleController.text,
                                "desc": descController.text,
                                "colorIndex": selectedColorIndex,
                                "date": dateController.text,
                              };
                            } else {
                              DummyDB.notesList.add({ // Edit allenkil new add aavum.
                                "title": titleController.text,
                                "desc": descController.text,
                                "date": dateController.text,
                                "colorIndex": selectedColorIndex
                              });
                            }
                            Navigator.pop(context); // Bottom sheet closing
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              isEdit ? "Update" : "Save", // isEdit aanenkil Update varum.
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}


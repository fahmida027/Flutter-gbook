// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gbook/notes_screen.dart';
import 'package:get/get.dart';

import 'database/db_helper.dart';
import 'home_page.dart';
import 'model/note.dart';
class UpdateNotes extends StatefulWidget {

  final notes;
  const UpdateNotes({super.key,required this.notes});

  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {

  late DatabaseHelper dbHelper;

  var titleController=TextEditingController();
  var descriptionController=TextEditingController();

  final GlobalKey<FormState> noteFormKey = GlobalKey();

  int? id;



  //add notes to database
  Future  updateNotes(int id) async
  {
    final updatedNote = Note(
      title: titleController.text,
      description: descriptionController.text,
    );

    int check= await dbHelper.updateData(updatedNote.toMap(),id);
    print("Check=$check");
    if(check>0)
    {

      Get.snackbar("Updated", "Note Updated",snackPosition: SnackPosition.BOTTOM);
      Get.offAll(const NotesScreen());

    }
    else
    {
      Get.snackbar("Error", "Error in note update",snackPosition: SnackPosition.BOTTOM);
    }


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DatabaseHelper.instance;
    titleController.text=widget.notes.title;
    descriptionController.text=widget.notes.description;
    id=widget.notes.id;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.blue,
        title: const Text("Updates Notes",style: TextStyle(
            color: Colors.white
        ),),


      ),
      body: Form(
        key: noteFormKey,
        child:SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [

              TextFormField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "Title",
                  prefixIcon: const Icon(Icons.note_alt_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter note title";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 10,),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Description",
                  prefixIcon: const Icon(Icons.notes),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter description";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 50,),

              ElevatedButton(
                style: ElevatedButton.styleFrom(

                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                onPressed: () async {
                  if(noteFormKey.currentState!.validate())
                  {
                    noteFormKey.currentState!.save();



                   updateNotes(id!);



                  }

                },
                child:  const Text(
                  "Update Notes",
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold),

                ),
              ),

            ],
          ),

        ) ,
      ),
    );
  }
}

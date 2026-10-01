import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todoapp/Studentadd.dart';

class Studentaddpage extends StatefulWidget {
  const Studentaddpage({super.key});

  @override
  State<Studentaddpage> createState() => _StudentaddpageState();
}

class _StudentaddpageState extends State<Studentaddpage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController fathernameController = TextEditingController();
  TextEditingController subjectsController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    fathernameController.dispose();
    subjectsController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  void savestudent(){
    String name = nameController.text;
    String fathername = fathernameController.text;
    String subjectsText = subjectsController.text.trim();

    List<String> subjectlist = subjectsText.isNotEmpty
        ? subjectsText.split(",").map((e)=>e.trim()).where((e)=>e.isNotEmpty).toList():[];
    if(name.isNotEmpty && fathername.isNotEmpty){
      final newstudent = Students(id : Random().nextInt(10000),name: name, fathername: fathername,subjects: subjectlist,);
      Navigator.pop(context,newstudent);
    }else{
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: const Text("Validation Error"),
        content: const Text("Please fill in both Name and Father Name fields."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Student"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Student Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: fathernameController,
              decoration: const InputDecoration(
                labelText: "Father Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: subjectsController,
              decoration: const InputDecoration(
                labelText: "Subjects (comma separated, e.g. Math, Science)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: savestudent,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Add Student",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}

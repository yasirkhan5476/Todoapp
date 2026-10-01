import 'package:flutter/material.dart';
import 'Studentadd.dart';

class Editstudent extends StatefulWidget {
  final Students editTostudent;

  const Editstudent({super.key, required this.editTostudent});

  @override
  State<Editstudent> createState() => _EditstudentState();
}

class _EditstudentState extends State<Editstudent> {
  late TextEditingController nameController;
  late TextEditingController fathernameController;
  late TextEditingController subjectsController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.editTostudent.name);
    fathernameController = TextEditingController(text: widget.editTostudent.fathername);
    subjectsController = TextEditingController(
      text: widget.editTostudent.subjects?.join(', ') ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    fathernameController.dispose();
    subjectsController.dispose();
    super.dispose();
  }

  void savestudent() {
    String name = nameController.text.trim();
    String fathername = fathernameController.text.trim();
    String subjectsText = subjectsController.text.trim();

    List<String> subjectsList = subjectsText.isNotEmpty
        ? subjectsText.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList()
        : [];

    if (name.isNotEmpty && fathername.isNotEmpty) {
      final updatedStudent = Students(
        id: widget.editTostudent.id,
        name: name,
        fathername: fathername,
        subjects: subjectsList,
      );
      Navigator.pop(context, updatedStudent);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Validation Error"),
          content: const Text("Please fill in both Name and Father Name fields."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Student Details"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
                  labelText: "Subjects (comma separated)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: savestudent,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.save, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "Update Student",
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
      ),
    );
  }
}
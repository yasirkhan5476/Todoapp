import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todoapp/EditStudent.dart';
import 'package:todoapp/Studentaddpage.dart';

class Studentadd extends StatefulWidget {
  const Studentadd({super.key});

  @override
  State<Studentadd> createState() => _StudentaddState();
}
class Students{
  int? id;
  String name;
  String fathername;
  List<String>? subjects;
  Students({this.id,required this.name,required this.fathername, this.subjects});
}

class _StudentaddState extends State<Studentadd> {
  @override

  List<Students> students = [
    Students(id: Random().nextInt(10000), name: "Yasir", fathername: "Idrees",subjects: ["Math", "Flutter", "Database"],),

  ];
  Widget mycomponent({required Students student,required int index,required VoidCallback onedit,required VoidCallback ondelete }){
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 6,horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text("${index+1}",
            style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          ),

        ),
        title: Text(student.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Father: ${student.fathername}"),
              if(student.subjects !=null&& student.subjects!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    "Subjects: ${student.subjects!.join(', ')}",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),


            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onedit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: ondelete,
            ),
          ],
        ),
      ),
    );
  }
  void deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
  }
  Future<void> _addstudent() async{
    final results= await Navigator.push(context, MaterialPageRoute(builder: (context)=>Studentaddpage()));
    if(results!=null && results is Students){
      setState(() {
       students.add(results);
      });

    }
  }
  Future<void> _editstudent(Students student, int index) async{
    final results= await Navigator.push(context, MaterialPageRoute(builder: (context)=>Editstudent(editTostudent: student,)));
    if(results!=null && results is Students){
      setState(() {
        students[index]=results;
      });

    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Todo app",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
      ),
      body: students.isEmpty
          ?const Center(
        child: Text(
          "No students added yet!",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ): ListView.builder(
          itemCount: students.length,
          shrinkWrap: true,
          itemBuilder: (context,index){
            final student=students[index];
            return mycomponent(student: student, index: index, onedit: ()=>_editstudent(student,index), ondelete:() =>deleteStudent(index));
          }
      ) ,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        onPressed: (){
        _addstudent();
      },child: Icon(
        Icons.add,
      ),

      ),
    );
  }
}

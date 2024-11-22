import 'package:employe_appwrite/appwriteservices.dart';
import 'package:employe_appwrite/list.dart';
import 'package:flutter/material.dart';


class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreen();
}

class _EmployeeScreen extends State<EmployeeScreen> {
  late AppwriteService _appwriteService;
  late List<Note> _notes;
 final nameC=TextEditingController();
 final ageC=TextEditingController();
 final locationC=TextEditingController();
 

  @override
void initState(){
  super.initState();
  _appwriteService=AppwriteService();
  _notes=[];
  _loadNotes();
}
Future<void>_loadNotes()async{
  try{
    final tasks= await _appwriteService.getNotes();
    setState(() {
      _notes=tasks.map((e)=>Note.fromDocument(e)).toList();
      
    });
  }
  catch(e){
    print("Error Loading Tasks:$e");
  }
}
Future<void> _addNote()async{
  final name=nameC.text;
  final age=ageC.text;
  final location=locationC.text;
 
  if (name.isNotEmpty&&
  age.isNotEmpty&&
  location.isNotEmpty
 
  ){
    try{
      await _appwriteService.addNote(name, age, location);
      nameC.clear();
     ageC.clear();
      locationC.clear();
      _loadNotes();
    }
    catch(e){
      print("Error loading tasks:$e");
    }
  }
}
Future<void>_deleteNote(String taskId)async{
  try{
    await _appwriteService.deleteNote(taskId);
    _loadNotes();
  }catch(e){
    print("Error Deleting Task:$e");
  }
}



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NoteApp using Appwrite"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
          SizedBox(height: 20,),
            TextFormField(
              controller: nameC,
              decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Name")),
            ),
             SizedBox(height: 20,),
            TextFormField(
              controller: ageC,
              decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Age")),
            ),
             SizedBox(height: 20,),
            TextFormField(
              controller: locationC,
              decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Location")),
            ),
           
            SizedBox(height: 25,),
            ElevatedButton(onPressed: _addNote, child: Text("Add")),
            SizedBox(height: 20,),
            Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
            itemCount: _notes.length,
             itemBuilder: (context,index){
              final notes=_notes[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.pink[200],
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          Text(notes.name),
                                Text(notes.age),
                                Text(notes.location),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    
                                    Center(
                                      child: Row(
                                        children: [
                                          IconButton(onPressed: ()=> _deleteNote(notes.id), icon: Icon(Icons.delete)),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                      ],
                    
                    ),
                  ),
                ),
              );
             }))
          ],
        ),
      ),
    );
  }
}
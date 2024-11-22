import 'package:appwrite/models.dart';

class Note {
  final String id;
  final String name;
  final String age;
  final String location;
 

  Note({
    required this.id,
    required this.name,
    required this.age,
    required this.location,
    
  });

  factory Note.fromDocument(Document doc) {
    return Note(
      id: doc.$id,
      name: doc.data['name'],
      age: doc.data['age'],
      location: doc.data['location'],
     
    );
  }
}
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AppwriteService {
  late Client client;

  late Databases databases;

  static const endpoint = 'https://cloud.appwrite.io/v1';
  static const projectId = '674026be00320e56b135';
  static const databaseId = '674026f9001ec6ca8d6c';
  static const collectionId = '67402703001ec790a2cc';

  AppwriteService() {
    client = Client();
    client.setEndpoint(endpoint);
    client.setProject(projectId);
    databases = Databases(client);
  }

  Future<List<Document>> getNotes() async {
    try {
      final result = await databases.listDocuments(
        collectionId: collectionId,
        databaseId: databaseId,
      );
      return result.documents;
    } catch (e) {
      print('Error loading tasks: $e');
      rethrow;
    }
  }

 
  Future<Document> addNote(String name,String age,String location) async {
    try {
      final documentId = ID.unique(); 

      final result = await databases.createDocument(
        collectionId: collectionId,
        databaseId: databaseId,
        data: {
          'name': name,
          'age':age,
          'location':location,
          
        },
        documentId: documentId,
      );
      return result;
    } catch (e) {
      print('Error creating task: $e');
      rethrow;
    }
  }

  Future<void> deleteNote(String documentId) async {
    try {
      await databases.deleteDocument(
        collectionId: collectionId,
        documentId: documentId,
        databaseId: databaseId,
      );
    } catch (e) {
      print('Error deleting task: $e');
      rethrow;
    }
  }
}
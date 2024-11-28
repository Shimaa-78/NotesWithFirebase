import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sub_collections_state.dart';

class SubCollectionsCubit extends Cubit<SubCollectionsState> {
  List<Map<String, dynamic>> collections = [];

  SubCollectionsCubit() : super(SubCollectionsInitial());

  Future<void> getNotes(String Id) async {
    try {
      emit(getSubCollectionsLoading());
      // Get a reference to the 'collections' collection
      CollectionReference collectionsRef =
      FirebaseFirestore.instance.collection('collections');

      // Get the documents in the collection
      QuerySnapshot querySnapshot = await collectionsRef.doc(Id).collection(
          'Notes').get();

      // Convert the documents to a list of maps
      collections = querySnapshot.docs
          .map((doc) => {"id": doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
      // Handle the fetched collections
      print(collections);

      // You can use the collections in your UI or emit a state to update the UI
      emit(getSubCollectionsSuccess());
    } catch (e) {
      print("Error retrieving collections: $e");
      emit(getSubCollectionsError("Failed to load collections"));
    }
  }


  Future<void> addNote(String title, String note, String id) async {
    try {
      emit(addSubCollectionsLoading());

      if (title.isEmpty || note.isEmpty) {
        throw Exception("Title and Note cannot be empty");
      }
      print(
          "=========================================================Title ${title}");
      print(
          "=========================================================Note ${note}");
      print(
          "=========================================================id ${id}");
      await FirebaseFirestore.instance.collection('collections')
          .doc(id)
          .collection('Notes')
          .add({
        'title': title,
        'note': note,
      });

      emit(addSubCollectionsSuccess());
      getNotes(id);
    } catch (e) {
      print(e.toString());
      emit(addSubCollectionsError(e.toString()));
    }
  }


  void updateNote(String newNote, newTitle, String id, String docId) {
    emit(updateSubCollectionsLoading());
    FirebaseFirestore.instance
        .collection('collections')
        .doc(docId).collection('Notes').doc(id)
        .update({"title": newTitle, 'note': newNote
    })
        .then((_) {
      print('Collection with id $id updated successfully');
      emit(updateSubCollectionsSuccess());
      getNotes(docId);
    }).catchError((error) {
      emit(updateSubCollectionsError("Failed to update collection"));
      print('Failed to update collection: $error');
    });
  }

  void deleteeNote(String docId,String id) {
    emit(deleteSubCollectionsLoading());
    FirebaseFirestore.instance
        .collection('collections')
        .doc(docId).collection("Notes").doc(id)
        .delete()
        .then((_) {
      print('Collection with id $docId updated successfully');
      emit(deleteSubCollectionsSuccess());
      getNotes(docId);
    }).catchError((error) {
      emit(deleteSubCollectionsError("Failed to update collection"));
      print('Failed to update collection: $error');
    });
  }
}


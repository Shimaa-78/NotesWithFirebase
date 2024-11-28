import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Make sure you have this imported
part 'collections_state.dart';

class CollectionsCubit extends Cubit<CollectionsState> {
  List<Map<String, dynamic>> collections = [];
  CollectionsCubit() : super(CollectionsInitial());

  Future<void> addCollection(String name, String imageUrl) async {
    try {
      emit(CollectionsLoading());
      await FirebaseFirestore.instance.collection('collections').add({
        'title': name,
        'userId': FirebaseAuth.instance.currentUser?.uid,
        'imageUrl': imageUrl, // Add image URL
        'Notes': {},
      });
      emit(CollectionsSuccess());
      getCollections();
    } catch (e) {
      print(e.toString());
      emit(CollectionsError(e.toString()));
    }
  }


  void deleteCollection(String id) {
    FirebaseFirestore.instance
        .collection('collections')
        .doc(id)
        .delete()
        .then((_) {
      print('Collection with id $id deleted successfully');
      getCollections();
    }).catchError((error) {
      print('Failed to delete collection: $error');
    });
  }
  void updateCollection(String newName, String id, String base64Image) async {
    emit(updateCollectionsLoading());

    try {

      // Update the collection data in Firestore
      await FirebaseFirestore.instance.collection('collections').doc(id).update({
        "title": newName,
        "imageUrl": base64Image,
      });

      print('Collection with id $id updated successfully');
      emit(updateCollectionsSuccess());
      getCollections();  // Refresh the collections list
    } catch (error) {
      emit(updateCollectionsError("Failed to update collection"));
      print('========================================Failed to update collection: $error');
    }
  }



  Future<void> getCollections() async {
    try {
      emit(getCollectionsLoading()); // Emit loading state

      // Get the current user's ID
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null && userId.isNotEmpty) {
        // Fetch collections where userId matches the logged-in user
        var snapshot = await FirebaseFirestore.instance
            .collection('collections')
            .where('userId', isEqualTo: userId)
            .get();

        // Convert documents into a list of maps
        collections = snapshot.docs
            .map((doc) => {"id": doc.id, ...doc.data() as Map<String, dynamic>})
            .toList();

        print("Fetched Collections: $collections");

        emit(getCollectionsSuccess()); // Emit success state
      } else {
        // Handle case where userId is null or empty
        print("Error: User ID is null or empty.");
        emit(getCollectionsError("User is not logged in."));
      }
    } catch (e) {
      // Handle and log errors
      print("Error retrieving collections: $e");
      emit(getCollectionsError("Failed to load collections: $e"));
    }
  }

}

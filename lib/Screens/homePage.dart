
import 'package:notesappwithfirebase/Screens/updateCollesction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../Cubits/Collections/collections_cubit.dart';
import '../Cubits/Email_and_passwird_login/email_and_password_cubit.dart';
import '../Widgets/methods.dart';
import '../themecontroller.dart';
import 'LoginScreen.dart';
import 'SubCollections/Notes.dart';
import 'addCollection.dart';
import 'dart:convert';
import 'dart:typed_data'; // For Uint8List

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CollectionsCubit>().getCollections();
    Uint8List? imageBytes;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(

        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        leading:   IconButton(
          icon: Icon(themeController.isDarkMode.value
              ? Icons.dark_mode
              : Icons.light_mode),
          onPressed: () {
            themeController.toggleTheme(); // Toggle the theme
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child: Text(

              "Collections",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
        actions: [

          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: InkWell(
              onTap: () {
                context.read<EmailAndPawwordCubit>().logOut();
                Get.off(SignInScreen());
              },
              child: Icon(
                Icons.logout,
                color:  Color(0xff067E7A),
              ),
            ),


          ),
          SizedBox(width: 20),
        ],
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<CollectionsCubit, CollectionsState>(
          builder: (context, state) {
            if (state is getCollectionsLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: context.read<CollectionsCubit>().collections.length,
              itemBuilder: (context, index) {
                final collection = context.read<CollectionsCubit>().collections[index];

                if (collection['imageUrl'] != null) {
                  imageBytes = base64Decode(collection['imageUrl']); // Decode Base64 to bytes
                }

                return InkWell(
                  onTap: () {
                    Get.to(NotesPage(id: collection['id']));
                  },
                  onLongPress: () {
                    showDeleteDialog(context, () {
                      context.read<CollectionsCubit>().deleteCollection(collection['id']);
                    });
                  },
                  child: Card(
                    color: isDarkMode ? Colors.grey[850] : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          imageBytes != null
                              ? Image.memory(
                            imageBytes!,
                            height: 140,
                            width: 150,
                            fit: BoxFit.cover,
                          )
                              : Image.asset(
                            "assets/imges/collection.jpg",
                            height: 140,
                            width: 150,
                          ),
                          SizedBox(height: 10),
                          Text(
                            collection['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: isDarkMode ? Colors.white : Colors.teal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(updatecollection(
                                    title: collection['title'],
                                    id: collection['id'],
                                    image: imageBytes!,
                                  ));
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: isDarkMode ? Colors.white : Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Get.to(AddCollection());
        },
        backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        child: Icon(Icons.add, color:  Colors.teal),
      ),
    );
  }
}


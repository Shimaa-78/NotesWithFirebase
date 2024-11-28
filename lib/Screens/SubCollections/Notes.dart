import 'package:notesappwithfirebase/Screens/updateCollesction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Cubits/Collections/collections_cubit.dart';
import '../../Cubits/Email_and_passwird_login/email_and_password_cubit.dart';
import '../../Cubits/SubCollections/sub_collections_cubit.dart';
import '../../Widgets/methods.dart';
import '../LoginScreen.dart';
import '../addCollection.dart';
import 'UpdateNote.dart';
import 'addNote.dart';

class NotesPage extends StatefulWidget {
  final String id;

  NotesPage({super.key, required this.id});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();
    // Fetch subcollections when the page is first loaded
    context.read<SubCollectionsCubit>().getNotes(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    List collections = context.watch<SubCollectionsCubit>().collections;
    print(collections);

    // Check if the app is in dark mode
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child: Text(
              "Notes",
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
                color: Color(0xff067E7A),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<SubCollectionsCubit, SubCollectionsState>(
            builder: (context, state) {
              if (state is getSubCollectionsLoading) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                itemCount: collections.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(UpdateNotePage(docid: widget.id, title: collections[index]['title'], note: collections[index]['note'], id: collections[index]['id'],));
                    },
                    onLongPress: () {
                      showDeleteDialog(context, () {
                        context.read<SubCollectionsCubit>().deleteeNote(widget.id, collections[index]['id']);
                      });
                    },
                    child: Card(
                      color: isDarkMode ? Colors.grey[800] : Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              collections[index]['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: isDarkMode ? Colors.white : Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              collections[index]['note'],
                              style: TextStyle(
                                fontSize: 16,
                                color: isDarkMode ? Colors.white70 : Colors.grey,
                              ),
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Get.to(AddNotePage(id: widget.id));
        },
        backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        child: Icon(Icons.add, color:  Colors.teal),
      ),
    );
  }
}

import 'package:notesappwithfirebase/Widgets/TextFieldWedget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Cubits/SubCollections/sub_collections_cubit.dart';
import '../../Widgets/methods.dart';

class UpdateNotePage extends StatelessWidget {
  String docid;
  String note;
  String title;
  String id;

  UpdateNotePage({required this.docid, required this.title, required this.note,required this.id});

  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Set the initial values of the controllers when the page is built
    _titleController.text = title;
    _noteController.text = note;

    return BlocListener<SubCollectionsCubit, SubCollectionsState>(
      listener: (context, state) {
        if (state is getSubCollectionsError) {
          Get.snackbar(
            "Error",
            state.msg,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else if (state is getSubCollectionsSuccess) {
          Get.snackbar(
            "",
            "Collection Updated Successfully",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Update Note'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Input
                  Input(
                    hint: "Enter The Title",
                    label: "Title",
                    controller: _titleController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Title is required';
                      }
                    },
                  ),
                  SizedBox(height: 20),

                  // Note content Input
                  Input(
                    hint: "Write Your Note Here",
                    label: "Note",
                    controller: _noteController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Note content is required';
                      }
                    },
                    mxLines: 19,
                  ),
                  SizedBox(height: 20),

                  // Submit Button
                  InkWell(
                    onTap: () {
                      // Validate inputs before proceeding
                      if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
                        context.read<SubCollectionsCubit>().updateNote(
                            _noteController.text,
                          _titleController.text,


                          id,
                          docid

                        );
                        _titleController.clear();
                        _noteController.clear();
                      } else {
                        // Show an error message if inputs are empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Title and Note cannot be empty")),
                        );
                      }
                    },
                    child: BlocBuilder<SubCollectionsCubit, SubCollectionsState>(
                      builder: (context, state) {
                        if (state is addSubCollectionsLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return CustomButton("Update",context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

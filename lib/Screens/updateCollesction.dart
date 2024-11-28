
import 'dart:io';
import 'dart:typed_data';

import 'package:notesappwithfirebase/Widgets/TextFieldWedget.dart';
import 'package:notesappwithfirebase/Widgets/methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Cubits/Collections/collections_cubit.dart';
import '../Cubits/imageCubit/image_cubit.dart';

class updatecollection extends StatelessWidget {
  String title;
  String id;
  Uint8List image;
  updatecollection({super.key, required this.title, required this.id, required this.image});

  final _collectioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ImageCubit>();  // Use ImageCubit to handle image logic
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<CollectionsCubit, CollectionsState>(
      listener: (context, state) {
        if (state is updateCollectionsError) {
          Get.snackbar(
            "Error",
            state.msg,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else if (state is updateCollectionsSuccess) {
          Get.snackbar(
            "Success",
            "Collection Updated Successfully",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Update Collection",
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          ),
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
          iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image Picker Widget
                  BlocBuilder<ImageCubit, ImageState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          cubit.pickImage();  // Pick image when user taps
                        },
                        child: cubit.selectedImage != null
                            ? Image.file(cubit.selectedImage!, height: 140, width: 150)
                            : Image.memory(
                          image,
                          height: 140,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 30),

                  // Text Form for Collection Name
                  Form(
                    key: _formKey,
                    child: Input(
                      hint: title,
                      label: "Enter New Collection Name",
                      controller: _collectioController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Collection Name is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 70),

                  // Update Button
                  BlocBuilder<ImageCubit, ImageState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            String? base64Image = cubit.encodeImageToBase64(cubit.selectedImage);
                            print("base64Image: $base64Image");

                            // Check if base64Image is null
                            if (base64Image != null) {
                              // Proceed with the update collection logic
                              context.read<CollectionsCubit>().updateCollection(
                                  _collectioController.text, id, base64Image
                              );
                              cubit.selectedImage = null;
                            } else {
                              // Handle the case where image is not selected
                              Get.snackbar(
                                "Error",
                                "Please select an image before updating.",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          }
                        },
                        child: BlocBuilder<CollectionsCubit, CollectionsState>(
                          builder: (context, state) {
                            if (state is updateCollectionsLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return CustomButton("Update", context);
                          },
                        ),
                      );
                    },
                  )

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


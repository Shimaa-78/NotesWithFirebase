

import 'package:notesappwithfirebase/Widgets/TextFieldWedget.dart';
import 'package:notesappwithfirebase/Widgets/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Cubits/Collections/collections_cubit.dart';
import '../Cubits/imageCubit/image_cubit.dart';

class AddCollection extends StatelessWidget {
  AddCollection({super.key});

  final _collectioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ImageCubit>(); // This should work now if ImageCubit is properly provided
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<CollectionsCubit, CollectionsState>(
      listener: (context, state) {
        if (state is CollectionsError) {
          Get.snackbar(
            "Error",
            state.msg,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else if (state is CollectionsSuccess) {
          Get.snackbar(
            "Success",
            "Collection Added Successfully",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Add Collection",
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          ),
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
          iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Column(
                children: [
                  BlocBuilder<ImageCubit, ImageState>(
                    builder: (context, state) {
                      // If the image is being picked, show a loading indicator
                      if (state is ImagePickLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      // Show the picked image or a default icon
                      return InkWell(
                        onTap: () {
                          // Trigger the image picking process
                          context.read<ImageCubit>().pickImage();
                        },
                        child: cubit.selectedImage != null
                            ? Image.file(
                          cubit.selectedImage!, // Display the selected image
                          height: 140,
                          width: 150,
                        )
                            : Icon(
                          Icons.image,
                          size: 100,
                          color: isDarkMode ? Colors.white : Colors.grey,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 70),
                  Form(
                    key: _formKey,
                    child: Input(
                      hint: "Collection Name",
                      label: "Enter Collection Name",
                      controller: _collectioController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 70),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        final base64Image = cubit.encodeImageToBase64(
                            cubit.selectedImage);
                        context.read<CollectionsCubit>().addCollection(
                          _collectioController.text,
                          base64Image!,
                        );
                        cubit.selectedImage = null;
                      }
                    },
                    child: BlocBuilder<CollectionsCubit, CollectionsState>(
                      builder: (context, state) {
                        if (state is CollectionsLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return CustomButton(
                          "Add Collection",
                          context,

                        );
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

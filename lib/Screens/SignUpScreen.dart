


import 'package:notesappwithfirebase/Cubits/GoogleCubit/google_cubit.dart';
import 'package:notesappwithfirebase/Screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../Cubits/Email_and_passwird_login/email_and_password_cubit.dart';
import '../Widgets/TextFieldWedget.dart';
import '../Widgets/methods.dart';
import '../Widgets/welcomeWidget.dart';
import '../Widgets/passwordTextField.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Access the current theme
    final isDarkMode = theme.brightness == Brightness.dark;

    return BlocListener<EmailAndPawwordCubit, EmailAndPasswordState>(
      listener: (context, state) {
        if (state is EmailAndPasswordSignUpError) {
          Get.snackbar(
            "Error",
            state.msg,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xff067E7A),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: WelcomWedget(txt: "Sign Up"),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.2),
                    blurRadius: 7,
                    offset: const Offset(3, 0),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                color: theme.cardColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 20,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Input(
                        hint: "Enter Your Email",
                        label: "Email",
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Input(
                        hint: "Enter Your Name",
                        label: "Name",
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      PasswordInput(
                        hint: "Enter Your Password",
                        label: "Password",
                        initialObs: true,
                        icon: Icons.visibility_off,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      PasswordInput(
                        hint: "Confirm Your Password",
                        label: "Confirm Password",
                        initialObs: true,
                        icon: Icons.visibility_off,
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirmation password is required';
                          } else if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<EmailAndPawwordCubit>().SignUp(
                              _emailController.text,
                              _passwordController.text,
                            );

                            _passwordController.clear();
                            _emailController.clear();
                            _confirmPasswordController.clear();
                            _nameController.clear();
                          }
                        },
                        child: BlocBuilder<EmailAndPawwordCubit,
                            EmailAndPasswordState>(
                          builder: (context, state) {
                            if (state is EmailAndPasswordSignUpLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return CustomButton("Sign Up",context);
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Center(
                        child: Text(
                          "OR",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () async {
                          await context.read<GoogleCubit>().signInWithGoogle();
                          Get.offAll(HomePage());
                        },
                        child: CustomButton("Continue With Google",context),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


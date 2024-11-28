import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import '../../Screens/LoginScreen.dart';
import '../../Screens/homePage.dart';
import '../Collections/collections_cubit.dart';

part 'email_and_password_state.dart';

class EmailAndPawwordCubit extends Cubit<EmailAndPasswordState> {
  EmailAndPawwordCubit() : super(EmailAndPasswordInitial());


  void SignUp(String email, String pass) async {
    try {
      emit(EmailAndPasswordSignUpLoading());
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      // Send email verification
      await credential.user?.sendEmailVerification();

      // Notify user to check their email
      emit(EmailAndPasswordSignUpSuccess());
      Get.snackbar(
        "Verify Your Email",
        "A verification email has been sent to $email. Please verify your email before logging in.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(EmailAndPasswordSignUpError("The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        emit(EmailAndPasswordSignUpError("The account already exists for that email."));
      }
    } catch (e) {
      emit(EmailAndPasswordSignUpError("An unexpected error occurred: $e"));
    }
  }




  void SignIn(String email, String password) async {
    try {
      emit(EmailAndPasswordLoginLoading());
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if the email is verified
      if (credential.user?.emailVerified == true) {
        Get.offAll(HomePage());
        emit(EmailAndPasswordLoginSuccess());
      } else {
        // Sign out the user if email is not verified
        await FirebaseAuth.instance.signOut();
        emit(EmailAndPasswordLoginError("Please verify your email before logging in."));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(EmailAndPasswordLoginError("No user found for that email."));
      } else if (e.code == 'wrong-password') {
        emit(EmailAndPasswordLoginError("Wrong password provided for that user."));
      } else {
        emit(EmailAndPasswordLoginError("Authentication failed: ${e.message}"));
      }
    } catch (e) {
      emit(EmailAndPasswordLoginError("An unexpected error occurred: $e"));
    }
  }



  void logOut() async {
    await GoogleSignIn().disconnect();
    await FirebaseAuth.instance.signOut();
  }

  void resetPassword(String email) async {
    try {
      emit(ResetPassLoading());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ResetPassSuccess());

    } on FirebaseAuthException catch (e) {

      if (e.code == 'user-not-found') {
        print("No user found with this email.");
        emit(ResetPassError("No user found with this email."));
      } else {
        print("An error occurred. Please try again.") ;
        emit(ResetPassError("An error occurred. Please try again."));
      }

    }
  }
}

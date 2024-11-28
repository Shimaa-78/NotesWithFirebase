import 'package:notesappwithfirebase/Cubits/GoogleCubit/google_cubit.dart';
import 'package:notesappwithfirebase/Cubits/imageCubit/image_cubit.dart';
import 'package:notesappwithfirebase/Screens/homePage.dart';
import 'package:notesappwithfirebase/themeService.dart';
import 'package:notesappwithfirebase/themecontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'Cubits/Collections/collections_cubit.dart';
import 'Cubits/Email_and_passwird_login/email_and_password_cubit.dart';
import 'Cubits/SubCollections/sub_collections_cubit.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/SignUpScreen.dart';
import 'firebase_options.dart';


void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(ThemeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EmailAndPawwordCubit()),
        BlocProvider(create: (context) => GoogleCubit()),
        BlocProvider(create: (context) => CollectionsCubit()),
        BlocProvider(create: (context) => SubCollectionsCubit()),
        BlocProvider(create: (context) => ImageCubit()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeService().lightTheme,
        darkTheme: ThemeService().darkTheme,
        themeMode: ThemeService().getThemeMode(),
        home: Scaffold(
          body: FirebaseAuth.instance.currentUser == null
              ? SignInScreen()
              : HomePage(),

        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../Cubits/Email_and_passwird_login/email_and_password_cubit.dart';
// import '../Cubits/GoogleCubit/google_cubit.dart';
// import '../Widgets/TextFieldWedget.dart';
// import '../Widgets/methods.dart';
// import '../Widgets/welcomeWidget.dart';
// import '../Widgets/passwordTextField.dart';
// import 'SignUpScreen.dart';
// import 'homePage.dart';
//
// class SignInScreen extends StatelessWidget {
//   SignInScreen({super.key});
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//
//   final _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<EmailAndPawwordCubit, EmailAndPasswordState>(
//       listener: (context, state) {
//         if (state is EmailAndPasswordLoginError) {
//           Get.snackbar(
//             "Error",
//             state.msg,
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );
//         }
//         else if(state is ResetPassError){
//           Get.snackbar(
//             "Error",
//             state.msg,
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );}
//         else if(state is ResetPassSuccess){
//           Get.snackbar(
//             "",
//             "Check your Mail box",
//             backgroundColor: Colors.green,
//             colorText: Colors.white,
//           );
//
//         }
//       },
//       child: Scaffold(
//         backgroundColor: Color(0xff067E7A),
//         body: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(40.0),
//               child: WelcomWedget(txt: "Sign In"),
//             ),
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey,
//                       blurRadius: 7, // Blur radius
//                       offset: Offset(3, 0), // Changes position of shadow (x, y)
//                     ),
//                   ],
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(35),
//                       topRight: Radius.circular(35)),
//                   color: Colors.white),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     // crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       SizedBox(
//                         height: 50,
//                       ),
//                       Input(
//                         hint: "Enter Your Email",
//                         label: "Email",
//                         controller: _emailController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Confirmation Email is required';
//                           }
//                         },
//                       ),
//                       SizedBox(
//                         height: 50,
//                       ),
//                       PasswordInput(
//                         hint: "Enter Your Password",
//                         label: "Password",
//                         initialObs: true,
//                         icon: Icons.visibility_off,
//                         controller: _passwordController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Confirmation password is required';
//                           }
//                         },
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       InkWell(
//                           onTap: () {
//
//                             context.read<EmailAndPawwordCubit>().resetPassword(_emailController.text);
//
//                           },
//                           child: Text(
//                             "Forget Password? ",
//                             style: TextStyle(
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.bold,fontSize: 18),
//                           )),
//                       SizedBox(
//                         height: 50,
//                       ),
//                       InkWell(onTap: () {
//                         if (_formKey.currentState!.validate()) {
//                           context.read<EmailAndPawwordCubit>().SignIn(
//                               _emailController.text, _passwordController.text);
//
//                           _passwordController.clear();
//                           _emailController.clear();
//                         }
//                       }, child: BlocBuilder<EmailAndPawwordCubit,
//                           EmailAndPasswordState>(
//                         builder: (context, state) {
//                           if (state is EmailAndPasswordLoginLoading) {
//                             return Center(child: CircularProgressIndicator());
//                           } else if (state is EmailAndPasswordLoginError) {
//                             return CustomButton("Sign In");
//                           }
//                           return CustomButton("Sign In");
//                         },
//                       )),
//                       SizedBox(
//                         height: 40,
//                       ),
//                       Center(
//                           child: Text("OR",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.grey))),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       InkWell(
//                           onTap: () async {
//                             await context
//                                 .read<GoogleCubit>()
//                                 .signInWithGoogle();
//                             Get.offAll(HomePage());
//                           },
//                           child: CustomButton("Continue With Google")),
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       //   children: [
//                       //     Icon(
//                       //       FontAwesomeIcons.google, // FontAwesome icon for Google
//                       //       size: 30,
//                       //       color: Color(0xff067E7A),
//                       //     ),
//                       //     Icon(
//                       //       FontAwesomeIcons
//                       //           .facebook, // FontAwesome icon for Google
//                       //       size: 30,
//                       //       color: Color(0xff067E7A),
//                       //     ),
//                       //     Icon(
//                       //       FontAwesomeIcons.twitter, // FontAwesome icon for Google
//                       //       size: 30,
//                       //       color: Color(0xff067E7A),
//                       //     ),
//                       //   ],
//                       // )
//                       // ,
//                       SizedBox(
//                         height: 50,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Dont have Account ? ",
//                             style: TextStyle(color: Colors.grey, fontSize: 18),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               Get.to(SignUpScreen());
//                             },
//                             child: Text(
//                               "Sign UP ",
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   color: Color(0xff067E7A),
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 80,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../Cubits/Email_and_passwird_login/email_and_password_cubit.dart';
import '../Cubits/GoogleCubit/google_cubit.dart';
import '../Widgets/TextFieldWedget.dart';
import '../Widgets/methods.dart';
import '../Widgets/passwordTextField.dart';
import 'SignUpScreen.dart';
import 'homePage.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<EmailAndPawwordCubit, EmailAndPasswordState>(
      listener: (context, state) {
        if (state is EmailAndPasswordLoginError) {
          Get.snackbar(
            "Error",
            state.msg,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else if (state is ResetPassError) {
          Get.snackbar(
            "Error",
            state.msg,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else if (state is ResetPassSuccess) {
          Get.snackbar(
            "",
            "Check your Mailbox",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(
        backgroundColor:  Color(0xff067E7A),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: isDarkTheme ? Colors.black54 : Colors.grey,
                    blurRadius: 7,
                    offset: Offset(3, 0),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                color: isDarkTheme ? Colors.grey[900] : Colors.white,
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Input(
                        hint: "Enter Your Email",
                        label: "Email",
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                        },
                      ),
                      SizedBox(height: 50),
                      PasswordInput(
                        hint: "Enter Your Password",
                        label: "Password",
                        initialObs: true,
                        icon: Icons.visibility_off,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          context
                              .read<EmailAndPawwordCubit>()
                              .resetPassword(_emailController.text);
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: isDarkTheme ? Colors.grey : Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<EmailAndPawwordCubit>().SignIn(
                                _emailController.text,
                                _passwordController.text);

                            _passwordController.clear();
                            _emailController.clear();
                          }
                        },
                        child: BlocBuilder<EmailAndPawwordCubit,
                            EmailAndPasswordState>(
                          builder: (context, state) {
                            if (state is EmailAndPasswordLoginLoading) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return CustomButton("Sign In",context);
                          },
                        ),
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: Text(
                          "OR",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDarkTheme ? Colors.grey : Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () async {
                          await context
                              .read<GoogleCubit>()
                              .signInWithGoogle();
                          Get.offAll(HomePage());
                        },
                        child: CustomButton("Continue With Google",context),
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: isDarkTheme ? Colors.grey : Colors.black54,
                              fontSize: 18,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(SignUpScreen());
                            },
                            child: Text(
                              " Sign Up",
                              style: TextStyle(
                                fontSize: 18,
                                color: isDarkTheme
                                    ? Colors.tealAccent
                                    : Color(0xff067E7A),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


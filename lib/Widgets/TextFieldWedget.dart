// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// class Input extends StatelessWidget {
//   Input({
//     super.key,
//     required this.hint,
//     required  this.label,
//     required this.controller,
//     required this.validator,
//     this.mxLines,
//
//   });
//
//   String hint;
//   String label;
// TextEditingController controller;
// int ?mxLines;
//   final String? Function(String?) validator;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 20),
//         ),
//         TextFormField(
//           controller: controller,
//           validator: validator,
//           cursorColor: Colors.grey[300],
//           maxLines: mxLines ?? 1,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(color: Colors.grey[300]),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(
//                   color: Colors.grey), // Gray underline on focus
//             ),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(
//                   color: Colors.grey), // Default underline
//             ),
//           ),
//           keyboardType: TextInputType.emailAddress,
//           obscureText: false,
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Input({
    super.key,
    required this.hint,
    required this.label,
    required this.controller,
    required this.validator,
    this.mxLines,
  });

  String hint;
  String label;
  TextEditingController controller;
  int? mxLines;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          cursorColor: isDarkMode ? Colors.grey[300] : Colors.grey[600],
          maxLines: mxLines ?? 1,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: isDarkMode ? Colors.grey[500] : Colors.grey[300],
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isDarkMode ? Colors.white : Colors.grey,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isDarkMode ? Colors.white : Colors.grey,
              ),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
        ),
      ],
    );
  }
}

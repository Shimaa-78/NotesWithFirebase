import 'package:flutter/material.dart';
// class WelcomWedget extends StatelessWidget {
//   WelcomWedget({
//     super.key,
//     required this.txt
//   });
//   String txt;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Welcome",
//           style: TextStyle(
//             color: Colors.grey[400],
//             fontSize: 16,
//           ),
//         ),
//         Text(
//           txt,
//           style: TextStyle(
//               color: Colors.white,
//               fontSize: 32,
//               fontWeight: FontWeight.bold),
//         )
//       ],
//     );
//   }
// }

class WelcomWedget extends StatelessWidget {
  WelcomWedget({
    super.key,
    required this.txt,
  });

  String txt;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome",
          style: TextStyle(
            color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
            fontSize: 16,
          ),
        ),
        Text(
          txt,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

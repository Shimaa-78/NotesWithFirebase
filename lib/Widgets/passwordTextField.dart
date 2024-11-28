import 'package:flutter/material.dart';

// class PasswordInput extends StatefulWidget {
//   final String hint;
//   final String label;
//   final bool initialObs; // Whether the text should initially be obscured
//   final IconData? icon;
//   final TextEditingController controller;
//   final String? Function(String?) validator;
//
//   const PasswordInput({
//     super.key,
//     required this.hint,
//     required this.label,
//     required this.initialObs,
//     this.icon, required this.controller, required  this.validator ,
//   });
//
//   @override
//   State<PasswordInput> createState() => _PasswordInputState();
// }
//
// class _PasswordInputState extends State<PasswordInput> {
//   late bool obs;
//   late IconData i;
//
//   @override
//   void initState() {
//     super.initState();
//     obs = widget.initialObs; // Initialize obscureText based on passed value
//     i = widget.icon ?? Icons.visibility_off; // Default icon if none provided
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.label,
//           style: const TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         TextFormField(
//           controller: widget.controller,
//           validator: widget.validator,
//           cursorColor: Colors.grey[300],
//           decoration: InputDecoration(
//             suffixIcon: InkWell(
//               onTap: () {
//                 setState(() {
//                   obs = !obs; // Toggle obscureText
//                   i = obs ? Icons.visibility_off : Icons.visibility; // Toggle icon
//                 });
//               },
//               child: Icon(i), // Dynamically change icon
//             ),
//             hintText: widget.hint,
//             hintStyle: TextStyle(color: Colors.grey[300]),
//             focusedBorder: const UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.grey, // Gray underline on focus
//               ),
//             ),
//             enabledBorder: const UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.grey, // Default underline
//               ),
//             ),
//           ),
//           keyboardType: TextInputType.text,
//           obscureText: obs, // Obscure text based on `obs`
//         ),
//       ],
//     );
//   }
// }

class PasswordInput extends StatefulWidget {
  final String hint;
  final String label;
  final bool initialObs;
  final IconData? icon;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const PasswordInput({
    super.key,
    required this.hint,
    required this.label,
    required this.initialObs,
    this.icon, required this.controller, required this.validator,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  late bool obs;
  late IconData i;

  @override
  void initState() {
    super.initState();
    obs = widget.initialObs;
    i = widget.icon ?? Icons.visibility_off;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          cursorColor: isDarkMode ? Colors.grey[300] : Colors.grey[600],
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  obs = !obs;
                  i = obs ? Icons.visibility_off : Icons.visibility;
                });
              },
              child: Icon(i, color: isDarkMode ? Colors.white : Colors.black),
            ),
            hintText: widget.hint,
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
          obscureText: obs,
        ),
      ],
    );
  }
}


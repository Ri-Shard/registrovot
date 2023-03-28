// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class LoginMobile extends StatefulWidget {
//   const LoginMobile({Key? key}) : super(key: key);

//   @override
//   State<LoginMobile> createState() => _LoginMobileState();
// }

// class _LoginMobileState extends State<LoginMobile> {
//   bool _isChecked = false;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(30),
//           child: Center(
//             child: SizedBox(
//               width: 300,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     'Bienvenido',
//                     style: GoogleFonts.inter(
//                       fontSize: 17,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Ingresa a tu Cuenta',
//                     style: GoogleFonts.inter(
//                       fontSize: 23,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const SizedBox(height: 35),
//                   TextField(
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       hintText: 'abc@example.com',
//                       labelStyle: GoogleFonts.inter(
//                         fontSize: 14,
//                         color: Colors.black,
//                       ),
//                       enabledBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                           width: 1,
//                         ),
//                       ),
//                       focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                           width: 1,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextField(
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: 'Contraseña',
//                       hintText: '********',
//                       labelStyle: GoogleFonts.inter(
//                         fontSize: 14,
//                         color: Colors.black,
//                       ),
//                       enabledBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                           width: 1,
//                         ),
//                       ),
//                       focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                           width: 1,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 25),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           SizedBox(
//                             height: 24,
//                             width: 24,
//                             child: Checkbox(
//                                 value: _isChecked, onChanged: onChanged),
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             'Recordarme',
//                             style: GoogleFonts.inter(
//                               fontSize: 14,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 30),
//                   TextButton(
//                     onPressed: () {},
//                     style: TextButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 20,
//                         horizontal: 10,
//                       ),
//                     ),
//                     child: Text(
//                       'Login',
//                       style: GoogleFonts.inter(
//                         fontSize: 15,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void onChanged(bool? value) {
//     setState(() {
//       _isChecked = value!;
//     });
//   }
// }

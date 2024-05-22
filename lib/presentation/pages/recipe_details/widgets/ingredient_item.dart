//
//
// import 'package:flutter/material.dart';
//
// import '../../../../domain/entities/ingredient.dart';
//
// class IngredientItem extends StatelessWidget {
//   final Ingredient ingredient;
//
//   const IngredientItem({
//     Key? key,
//     required this.ingredient,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Container(
//             width: 10,
//             height: 10,
//             decoration: BoxDecoration(
//               color: Colors.green,
//               shape: BoxShape.circle,
//             ),
//           ),
//           SizedBox(width: 10),
//           Text(
//             ingredient.name,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
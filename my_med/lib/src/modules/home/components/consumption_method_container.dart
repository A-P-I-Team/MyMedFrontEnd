// import 'package:flutter/material.dart';
// import 'package:my_med/src/modules/home/models/active_prescription_model.dart';

// class ConsumptionMethodContainer extends StatelessWidget {
//   final String text;
//   final String? consumptionMethods;
//   final ActivePrescriptionModel activePrescriptionModel;

//   const ConsumptionMethodContainer({
//     Key? key,
//     required this.text,
//     this.consumptionMethods,
//     required this.activePrescriptionModel,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: (activePrescriptionModel.consumptionMethod == consumptionMethods)
//             ? const Color(0x255EAFC0)
//             : Colors.transparent,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
//         child: Text(
//           text,
//           style: const TextStyle(
//             fontWeight: FontWeight.w700,
//             fontSize: 12,
//             color: Color(0xFF5EAFC0),
//           ),
//           textAlign: TextAlign.center,
//           maxLines: 1,
//         ),
//       ),
//     );
//   }
// }

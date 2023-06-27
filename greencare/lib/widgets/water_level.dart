// import 'package:flutter/material.dart';

// class WaterLevel extends StatefulWidget {
//   const WaterLevel({super.key});

//   @override
//   State<WaterLevel> createState() => _WaterLevelState();
// }

// class _WaterLevelState extends State<WaterLevel> {
//   var water_level = 50.0;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         alignment: Alignment.center,
//         height: 180,
//         width: 200,
//         child: LiquidCircularProgressIndicator(
//           value: water_level / 100, // Defaults to 0.5.
//           valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 30, 159,
//               233)), // Defaults to the current Theme's accentColor.
//           backgroundColor:
//               Colors.white, // Defaults to the current Theme's backgroundColor.
//           borderColor: Colors.red,
//           borderWidth: 0.0,
//           direction: Axis.vertical,
//           // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
//           center: Text(
//             "$water_level %",
//             style: TextStyle(color: Colors.grey[300], fontSize: 20),
//           ),
//         ),
//       ),
//     );
//   }
// }
// 
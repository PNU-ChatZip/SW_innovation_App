// import 'package:flutter/material.dart';
// import 'package:kakao_map_plugin/kakao_map_plugin.dart';

// import '../api/Restapi.dart';
// import '../kakaomap.dart';
// import '../model/location.dart';

// class BottomTab extends StatefulWidget {
//   const BottomTab({super.key});

//   @override
//   State<BottomTab> createState() => _BottomTabState();
// }

// class _BottomTabState extends State<BottomTab> {
//   // A list to hold the received locations
//   List<location> _receivedLocations = [];

//   //retrieve locations from server
//   void _retrieveLocations() async {
//     try {
//       List<location> locations = await Api().receiveLocation();
//       // Use setState to update the UI with the received locations
//       setState(() {
//         _receivedLocations = locations;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to retrieve locations: $e'),
//           backgroundColor: Colors.red,
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   //press button to send location and show snackbar
//   void _printCurrentLocation(String type) async {
//     try {
//       LatLng currentLocation = await getLocation();
//       print("${currentLocation.latitude} ${currentLocation.longitude}");
//       location loc = location(currentLocation.latitude.toString(),
//           currentLocation.longitude.toString(), type, DateTime.now().toIso8601String());
//       await Api().sendLocation(loc);

//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         TextButton(
//           onPressed: () {
//             showModalBottomSheet<void>(
//               context: context,
//               builder: (BuildContext context) {
//                 return SizedBox(
//                   height: 400,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(
//                           12.0), // Set the border radius here
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Column(
//                               children: [
//                                 IconButton.outlined(
//                                   onPressed: () {},
//                                   icon: Icon(Icons.abc),
//                                   tooltip: "포트홀 신고",
//                                   style: ButtonStyle(
//                                     shape: MaterialStateProperty.all<
//                                         RoundedRectangleBorder>(
//                                       RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(20.0),
//                                       ),
//                                     ),
//                                     padding:
//                                         MaterialStateProperty.all<EdgeInsets>(
//                                       const EdgeInsets.all(40.0),
//                                     ),
//                                     textStyle:
//                                         MaterialStateProperty.all<TextStyle>(
//                                       const TextStyle(
//                                           fontSize: 16), // Set the font size
//                                     ),
//                                     foregroundColor:
//                                         MaterialStateProperty.all<Color>(
//                                             Color.fromRGBO(143, 148, 251, 1)),
//                                     backgroundColor:
//                                         MaterialStateProperty.all<Color>(
//                                       Colors.white,
//                                     ),
//                                     side: MaterialStateProperty.all<BorderSide>(
//                                       const BorderSide(
//                                           color:
//                                               Color.fromRGBO(143, 148, 251, 1),
//                                           width:
//                                               2), // Set border color and width
//                                     ),
//                                   ),
//                                 ),
//                                 Text("포트홀"),
//                               ],
//                             ),
//                             // ElevatedButton(
//                             //   onPressed: () {
//                             //     _printCurrentLocation("포트홀");
//                             //   },
//                             //   child: Text("포트홀"),
//                             // ),
//                             ElevatedButton(
//                               onPressed: () {
//                                 _printCurrentLocation("도로 막힘");
//                               },
//                               child: Text("도로 막힘"),
//                             ),
//                             ElevatedButton(
//                               onPressed: () {
//                                 _printCurrentLocation("차량 사고");
//                               },
//                               child: Text("차량 사고"),
//                             ),
//                           ],
//                         ),
//                         ElevatedButton(
//                           style: ButtonStyle(
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                             ),
//                             padding: MaterialStateProperty.all<EdgeInsets>(
//                               const EdgeInsets.symmetric(
//                                   vertical: 12.0,
//                                   horizontal:
//                                       100.0), // Set padding for all sides
//                             ),
//                             textStyle: MaterialStateProperty.all<TextStyle>(
//                               const TextStyle(
//                                   fontSize: 16), // Set the font size
//                             ),
//                             foregroundColor: MaterialStateProperty.all<Color>(
//                                 Color.fromRGBO(143, 148, 251, 1)),
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                               Colors.white,
//                             ),
//                             side: MaterialStateProperty.all<BorderSide>(
//                               const BorderSide(
//                                   color: Color.fromRGBO(143, 148, 251, 1),
//                                   width: 2), // Set border color and width
//                             ),
//                           ),
//                           child: const Text(
//                             '취소',
//                             style: TextStyle(
//                                 color: Color.fromRGBO(143, 148, 251, 1),
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//           style: ButtonStyle(
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//             ),
//             padding: MaterialStateProperty.all<EdgeInsets>(
//               const EdgeInsets.symmetric(
//                   vertical: 12.0,
//                   horizontal: 100.0), // Set padding for all sides
//             ),
//             textStyle: MaterialStateProperty.all<TextStyle>(
//               const TextStyle(fontSize: 16), // Set the font size
//             ),
//             foregroundColor: MaterialStateProperty.all<Color>(
//               Color.fromRGBO(143, 148, 251, 1),
//             ),
//             backgroundColor: MaterialStateProperty.all<Color>(
//               Color.fromRGBO(143, 148, 251, 1),
//             ),
//             side: MaterialStateProperty.all<BorderSide>(
//               const BorderSide(
//                   color: Color.fromRGBO(143, 148, 251, 1),
//                   width: 2), // Set border color and width
//             ),
//           ),
//           child: const Text(
//             "포트홀 신고하기",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
// }

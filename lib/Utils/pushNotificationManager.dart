// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:soundpool/soundpool.dart';
//
// class PushNotificationsManager {
//
//   static late BuildContext _context;
//   static Soundpool? _pool;
//   static final SoundpoolOptions _soundpoolOptions = SoundpoolOptions();
//
//   static init({required BuildContext context}) {
//     print("init pnm");
//     _context = context;
//     _pool?.dispose();
//       _pool = Soundpool.fromOptions(options: _soundpoolOptions);
//       print('pool updated: $_pool');
//   }
//
//   static handleBackgroundNotification(Map<String, dynamic> message) async {
//     print("pnm back");
//     print(message);
//   }
//
//   static handleNotification(RemoteMessage message) async {
//     try {
//       String? temp = message.notification?.body;
//       Map<String, dynamic> notificationData = jsonDecode(temp!);
//       var soundId = await rootBundle.load("assets/message_tone.mp3");
//       int sound = await _pool!.load(soundId);
//       int? streamId = await _pool?.play(sound);
//
//       showDialog(context: _context, builder: (_) {
//         return AlertDialog(
//           title: Text("Entry ${notificationData["notification_type"]}!"),
//           content: Text(
//               "Record: ${notificationData["entry"]}\n${notificationData["notification_type"]} by ${notificationData["user_name"]}"),
//           actions: [
//             TextButton(
//                 onPressed: () => Navigator.pop(_context),
//                 child: const Text("Ok"))
//           ],
//         );
//       });
//     }catch(error){
//       Fluttertoast.showToast(msg: "FCM data error");
//       print(error);
//
//     }
//
//   }
//
// }
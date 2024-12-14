//
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class UrlLauncherService {
//   static Future<void> launch(
//     BuildContext context, {
//     required Uri uri,
//     required String title,
//     required String content,
//   }) async {
//     if (!await launchUrl(uri)) {
//       if (!context.mounted) return;
//       await showPlatformAlertDialog(
//         context,
//         title: title,
//         content: content,
//         defaultActionText: 'OK',
//       );
//     }
//   }
// }

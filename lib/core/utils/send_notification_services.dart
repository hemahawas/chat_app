import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/core/utils/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

Future<String> getAccessToken() async {
  final jsonString = await rootBundle.loadString(
    'assets/keys/chat-app-e5cb1-8d448f79f16a.json',
  );

  final accountCredentials =
      auth.ServiceAccountCredentials.fromJson(jsonString);

  final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
  final client = await auth.clientViaServiceAccount(accountCredentials, scopes);

  return client.credentials.accessToken.data;
}

Future<void> sendNotification(
    {required String title,
    required String body,
    required Map<String, String> data}) async {
  final String accessToken = await getAccessToken();
  final String fcmUrl =
      'https://fcm.googleapis.com/v1/projects/chat-app-e5cb1/messages:send';
  String token = '';
  try {
    token = await TokenService.getToken();
  } on TokenException catch (e) {
    log(e.toString());
    return;
  }

  final response = await http.post(
    Uri.parse(fcmUrl),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    },
    body: jsonEncode(<String, dynamic>{
      'message': {
        'token': token,
        'notification': {
          'title': title,
          'body': body,
        },
        'data': data, // Add custom data here

        'android': {
          'notification': {
            "sound": "custom_sound",
            'click_action':
                'FLUTTER_NOTIFICATION_CLICK', // Required for tapping to trigger response
            'channel_id': 'high_importance_channel'
          },
        },
        'apns': {
          'payload': {
            'aps': {"sound": "custom_sound.caf", 'content-available': 1},
          },
        },
      },
    }),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification: ${response.body}');
  }
}

void handleNotification(BuildContext context, Map<String, dynamic> data) {
  String route = data['route'];
  String id = data['id'];

  if (route == '/product_detials') {}
}

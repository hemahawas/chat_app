import 'dart:convert';
import 'dart:io';

import 'package:chat_app/core/api/end_points.dart';
import 'package:chat_app/core/api/status_code.dart';

import 'package:http/http.dart' as http;

class CloudinaryService {
  Future<String> uploadImageThenGet(String image) async {
    final url = Uri.parse(EndPoints.cloudinaryUpload);
    // Enter the type of request
    final request = http.MultipartRequest('POST', url)
      // Choose the preset
      ..fields['upload_preset'] = 'upload'
      // then add the file that will be uploaded
      ..files.add(await http.MultipartFile.fromPath('file', image));

    final response = await request.send();

    if (response.statusCode == StatusCode.ok) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMaps = jsonDecode(responseString);
      return jsonMaps['url'];
    } else {
      throw Exception('Failed to upload image');
    }
  }
}

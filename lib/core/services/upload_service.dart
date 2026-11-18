import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'api_service.dart';

class UploadService {
  Future<String> uploadPdf(PlatformFile file) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("${ApiService.baseUrl}/api/upload"),
    );

    if (kIsWeb) {
      request.files.add(
        http.MultipartFile.fromBytes(
          "file",
          file.bytes!,
          filename: file.name,
        ),
      );
    } else {
      request.files.add(
        await http.MultipartFile.fromPath(
          "file",
          file.path!,
        ),
      );
    }

    var response = await request.send();
    return await response.stream.bytesToString();
  }
}
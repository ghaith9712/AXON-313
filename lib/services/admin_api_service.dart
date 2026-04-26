import 'dart:typed_data';

class AdminApiService {
  static Future<Map<String, dynamic>> uploadProductImage({
    required Uint8List bytes,
    required String fileName,
  }) async {
    return {'url': 'uploaded/$fileName'};
  }
}

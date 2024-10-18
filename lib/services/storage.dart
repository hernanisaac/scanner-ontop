import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = const FlutterSecureStorage();

Future<void> saveAccessToken(String token) async {
  await storage.write(key: 'accessToken', value: token);
}

Future<String?> getAccessToken() async {
  return await storage.read(key: 'accessToken');
}

Future<void> removeAccessToken() async {
  return await storage.delete(key: 'accessToken');
}

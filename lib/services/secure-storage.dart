import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final secureStore = new FlutterSecureStorage();
  void setSecureStore(String key, String data) async {
    await secureStore.write(key: key, value: data);
  }

  Future<String> getSecureStore(String key) async {
    return await secureStore.read(key: key);
  }

  Future<void> deleteSecureStore(String key) async {
    await secureStore.delete(key: key);
  }
}

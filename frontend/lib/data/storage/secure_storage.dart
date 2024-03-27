import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageYeongam {
  final secureStorage = const FlutterSecureStorage();

  Future<void> persistenToken(String token) async {
    await secureStorage.write(key: 'token', value: token);
  }

  Future<String?> readToken() async {
    // print('secure_storage.dart : readToken');
    var result = await secureStorage.read(key: 'token');
    // print(result);
    return result;
  }

  Future<void> deleteSecureStorage() async {
    // print('deleteSecureStorage');
    await secureStorage.delete(key: 'token');
    await secureStorage.deleteAll();
  }
}

final secureStorage = SecureStorageYeongam();

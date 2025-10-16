import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

/// Mock implementation of FlutterSecureStoragePlatform for testing
class MockSecureStoragePlatform extends FlutterSecureStoragePlatform {
  final Map<String, String> _storage = {};

  @override
  Future<void> write({
    required String key,
    required String value,
    required Map<String, String> options,
  }) async {
    _storage[key] = value;
  }

  @override
  Future<String?> read({
    required String key,
    required Map<String, String> options,
  }) async {
    return _storage[key];
  }

  @override
  Future<void> delete({
    required String key,
    required Map<String, String> options,
  }) async {
    _storage.remove(key);
  }

  @override
  Future<void> deleteAll({
    required Map<String, String> options,
  }) async {
    _storage.clear();
  }

  @override
  Future<Map<String, String>> readAll({
    required Map<String, String> options,
  }) async {
    return Map<String, String>.from(_storage);
  }

  @override
  Future<bool> containsKey({
    required String key,
    required Map<String, String> options,
  }) async {
    return _storage.containsKey(key);
  }

  /// Clear the mock storage (useful for test cleanup)
  void clear() {
    _storage.clear();
  }
}

/// Setup mock secure storage for tests
void setupMockSecureStorage() {
  final mockPlatform = MockSecureStoragePlatform();
  FlutterSecureStoragePlatform.instance = mockPlatform;
}

/// Get the mock platform instance for direct access if needed
MockSecureStoragePlatform getMockSecureStoragePlatform() {
  return FlutterSecureStoragePlatform.instance as MockSecureStoragePlatform;
}

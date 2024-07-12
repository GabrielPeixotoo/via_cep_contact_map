import 'dart:async';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../shared.dart';

class LocalStorageHiveAdapter implements LocalStorage {
  final Completer<Box> _instance = Completer<Box>();

  Future<void> _init() async {
    final Directory dir = await getApplicationSupportDirectory();
    Hive.init(dir.path);

    final box = await Hive.openBox('myBox');
    _instance.complete(box);
  }

  LocalStorageHiveAdapter() {
    _init();
  }

  @override
  Future<void> delete({required String key}) async {
    final box = await _instance.future;

    try {
      await box.delete(key);
    } catch (error, stackTrace) {
      throw CacheError.deleteCacheData(
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<String> fetch({required String key}) async {
    final box = await _instance.future;

    try {
      return await box.get(key) ?? '';
    } catch (error, stackTrace) {
      throw CacheError.fetchCacheData(
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> save({required String key, required String value}) async {
    final box = await _instance.future;

    try {
      await box.put(key, value);
    } catch (error, stackTrace) {
      throw CacheError.saveCacheData(
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

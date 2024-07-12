abstract class LocalStorage {
  Future<void> save({required String key, required String value});
  Future<String> fetch({required String key});
  Future<void> delete({required String key});
}

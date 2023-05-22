import '../interfaces/i_update.dart';

class ListenersContiner<T> {
  Map<String, T>
  container = <String, T>{};

  int size() {
    return container.length;
  }

  void register(String key, T listener) {
    container[key] = listener;
  }

  void unregister(String key) {
    container.remove(key);
  }

  void clear() {
    container.clear();
  }

  bool contains(String key) {
    return container.containsKey(key);
  }

  Map<String, T> listeners() {
    return container;
  }

  T? updater(String key) {
    return container[key];
  }

  String firstKey() {
    List<String> keysList = container.keys.toList();
    return keysList.isEmpty ? '' : keysList.first;
  }


}


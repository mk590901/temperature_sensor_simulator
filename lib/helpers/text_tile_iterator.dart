import '../interfaces/i_iterator.dart';

class TextTileIterator implements IIterator {

  final int id;
  int _counter = 0;
  late String? uuid = "";

  List<String> list = [ "125.4", "Welcome", "dart", "flutter", "toit" ];

  TextTileIterator(this.id);

  @override
  void setUuid(final String? uuid) {
    this.uuid = uuid;
  }

  @override
  dynamic next(final String? uuid_) {
    if ((uuid == uuid_) || (uuid_ == null)) {
      _counter++;
      if (_counter == list.length) {
        _counter = 0;
      }
    }
    return list[_counter];
  }
}


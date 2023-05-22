class Capability<T> {
  final String _name;
  late T? _value;

  Capability(this._name);

  void update(T? value) {
    _value = value;
  }

}
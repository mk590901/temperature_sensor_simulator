enum ErrorType { ok, failed, cancel, out_range, critical_low,  critical_high, warning_low,  warning_high }

int error_(ErrorType errorType) {
  return errorType.index;
}

class MeasurementError {
  final ErrorType _errorType;
  String? _description;

  MeasurementError(this._errorType) {
    _description = null;
  }

  ErrorType errorType() {
    return _errorType;
  }

  void setDescription(String? data) {
    _description = data;
  }

  String? description() {
    return _description;
  }
}

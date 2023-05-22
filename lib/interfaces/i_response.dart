abstract class IResponse<T,E> {
  void onFailed   ([E? error]);
  void onSucceded ([T? data]);
}
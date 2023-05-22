import 'controller.dart';
import '../interfaces/i_response.dart';

class Response<int,String> implements IResponse<int,String> {
  final Controller? _bloc;
  
  Response(this._bloc);
  
  @override
  void onFailed([String? error]) {
    //_bloc?.error(error);
  }

  @override
  void onSucceded([int? message]) {
    //_bloc?.success(message);
  }

}
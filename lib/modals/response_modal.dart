// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResponseModal {
  bool _isSuccess;
  String _message;

  ResponseModal(
    this._isSuccess,
    this._message,
  );

  String get message => _message;
  bool get isSuccess => _isSuccess;

}

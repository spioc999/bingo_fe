class ServiceResponse<T> {
  T? result;
  ServiceError? error;

  ServiceResponse({this.result, this.error});

  bool get hasError => error != null;
}

class ServiceError{
  int errorCode;
  String errorMessage;

  ServiceError(this.errorCode, this.errorMessage);
}
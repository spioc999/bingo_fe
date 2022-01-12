/// [ServiceResponse] is wrapper class used for returning data after
/// invoking any service method.
///
/// [result] is the actual response from service (the type can be specified
/// thanks to generics)
/// [error] is a [ServiceError] object that is populated only if error occurred
/// during retrieving or converting data.

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
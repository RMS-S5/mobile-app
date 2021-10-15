enum ExceptionTypes { HttpError, NotVerifiedError }

class ValidateException implements Exception {
  final String message;
  ExceptionTypes _errorType = ExceptionTypes.HttpError;

  ValidateException(this.message, {ExceptionTypes? errorType}) {
    if (errorType != null) {
      _errorType = errorType;
    }
  }

  ExceptionTypes get exceptionType {
    return _errorType;
  }

  @override
  String toString() {
    return message;
  }
}

class CustomException implements Exception {
  final String message;
  const CustomException({required this.message}) : super();
}

class BadRequestException extends CustomException {
  String? errorMessage;
  BadRequestException({this.errorMessage})
      : super(message: errorMessage ?? "Bad Request!");
}

class InternalServerError extends CustomException {
  String? errorMessage;
  InternalServerError({this.errorMessage})
      : super(message: errorMessage ?? "Internal server error!");
}

class ServerRequestTimeout extends CustomException {
  ServerRequestTimeout()
      : super(message: "Server request timeout! please try again");
}

class ConflictError extends CustomException {
  String? errorMessage;
  ConflictError({this.errorMessage})
      : super(message: errorMessage ?? "Confict Occured in server");
}

class NotFoundError extends CustomException {
  final String errorMessage;

  const NotFoundError({required this.errorMessage})
      : super(message: errorMessage);
}

class UnauthorizedError extends CustomException {
  final String errorMessage;
  const UnauthorizedError({required this.errorMessage})
      : super(message: errorMessage);
}

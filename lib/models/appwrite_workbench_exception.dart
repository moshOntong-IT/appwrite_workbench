class AppwriteWorkbenchException implements Exception {
  AppwriteWorkbenchException({
    required this.message,
    this.stackTrace,
    this.code = 0,
  });

  final String message;
  final StackTrace? stackTrace;
  final int code;

  @override
  String toString() => message;

  /// Maybe when method and return T
  T maybeWhen<T>({
    T Function()? unknown,
    T Function()? duplicate,
    T Function()? notFound,
    T Function()? noInternet,
    T Function()? unauthorized,
    T Function()? timeout,
    T Function()? invalidInput,
    T Function()? serverError,
    T Function()? permissionDenied,
    T Function()? resourceExhausted,
    T Function()? unimplemented,
    T Function()? unavailable,
    T Function()? dataLoss,
    T Function()? cancelled,
    T Function()? alreadyExists,
    // Add more as needed
    required T Function() orElse,
  }) {
    switch (code) {
      case 0:
        return unknown?.call() ?? orElse();
      case 1:
        return duplicate?.call() ?? orElse();
      case 2:
        return notFound?.call() ?? orElse();
      case 3:
        return noInternet?.call() ?? orElse();
      case 4:
        return unauthorized?.call() ?? orElse();
      case 5:
        return timeout?.call() ?? orElse();
      case 6:
        return invalidInput?.call() ?? orElse();
      case 7:
        return serverError?.call() ?? orElse();
      case 8:
        return permissionDenied?.call() ?? orElse();
      case 9:
        return resourceExhausted?.call() ?? orElse();
      case 10:
        return unimplemented?.call() ?? orElse();
      case 11:
        return unavailable?.call() ?? orElse();
      case 12:
        return dataLoss?.call() ?? orElse();
      case 13:
        return cancelled?.call() ?? orElse();
      case 14:
        return alreadyExists?.call() ?? orElse();
      // Add more as needed
      default:
        return orElse();
    }
  }
}

class UseCaseResult<T> with _UsecaseMethods<T> {
  late T? _data;
  late String? _error;

  bool get isError => _error != null;

  UseCaseResult._();

  UseCaseResult._successResult({required T data}) {
    _data = data;
  }

  UseCaseResult._errorResult({required String error}) {
    _error = error;
  }

  static UseCaseResult<T> Success<T>({required T data}) => UseCaseSuccess<T>(data: data);

  static UseCaseResult<T> Error<T>({required String error}) => UseCaseError<T>(error: error);
}

class UseCaseSuccess<T> extends UseCaseResult<T> {
  UseCaseSuccess({required T data}) : super._successResult(data: data);

  T get data => _data!;

  @override
  when({Function(T data)? onData, Function(String error)? onError}) {
    onData?.call(_data!);
  }
}

class UseCaseError<T> extends UseCaseResult<T> {
  UseCaseError({required String error}) : super._errorResult(error: error);

  String get error => _error!;

  @override
  when({Function(T data)? onData, Function(String error)? onError}) {
    onError?.call(_error!);
  }
}

mixin _UsecaseMethods<T> {
  when({Function(T data)? onData, Function(String error)? onError}) {}
}

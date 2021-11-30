import 'api_exception.dart';
import 'usecase_result.dart';

class APIResult<T> {
  T? _data;
  ApiException? _error;

  APIResult._();

  when({
    required Function(T data) onData,
    required Function(ApiException error) onFailure,
  }) {
    if (this is ApiSuccess) {
      onData(_data!);
    } else {
      onFailure(_error!);
    }
  }

  UseCaseResult<T> returnWhen({
    required UseCaseSuccess<T> Function(T data) onData,
    required UseCaseError<T> Function(ApiException error) onFailure,
  }) {
    if (this is ApiSuccess) {
      return onData(_data!);
    } else {
      return onFailure(_error!);
    }
  }

  UseCaseResult<T> returnUseCaseResultWhen({
    required T Function(T data) onData,
    required String Function(ApiException error) onFailure,
  }) {
    if (this is ApiSuccess) {
      return UseCaseSuccess(data: onData(_data!));
    } else {
      return UseCaseError(error: onFailure(_error!));
    }
  }

  APIResult._success({required T data}) {
    _data = data;
  }

  APIResult._failure({required ApiException error}) {
    _error = error;
  }

  static APIResult<T> Success<T>({required T data}) => ApiSuccess<T>(data: data);

  static APIResult<T> Failure<T>({required ApiException error}) => ApiFailure<T>(error: error);
}

class ApiSuccess<T> extends APIResult<T> {
  ApiSuccess({required T data}) : super._success(data: data);

  T get data => _data!;
}

class ApiFailure<T> extends APIResult<T> {
  ApiFailure({required ApiException error}) : super._failure(error: error);

  ApiException get error => _error!;
}

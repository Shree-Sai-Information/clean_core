import 'package:clean_core/clean_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('APIResult assumes correct type based on data provided', () {
    var result = APIResult.Success(data: true);
    expect(true, result is ApiSuccess<bool>);
  });

  test('APIResult `onFailure` is called in `when` method', () {
    var result = APIResult.Failure(error: ApiException.UnknownException());
    result.when(
      onData: neverCalled,
      onFailure: expectAsync1((e) {}),
    );
  });

  test('APIResult `onData` is called in `when` method', () {
    var result = APIResult.Success(data: "Called");
    result.when(
      onData: expectAsync1((e) {}),
      onFailure: neverCalled,
    );
  });

  test('APIResult `returnUseCaseResultWhen` returns correct type', () {
    var result = APIResult.Success(data: "Called");
    var useCaseResult = result.returnUseCaseResultWhen(onData: (d) {
      return d;
    }, onFailure: (e) {
      return e.message;
    });

    expect(true, useCaseResult is UseCaseSuccess<String>);
  });

  test('UseCaseResult assumes correct type based on data provided', () {
    var result = UseCaseSuccess(data: true);
    expect(true, result is UseCaseSuccess<bool>);
  });

  test('UseCaseResult `onError` is called in `when` method', () {
    var result = UseCaseResult.Error(error: "Some Error");
    result.when(
      onData: neverCalled,
      onError: expectAsync1((e) {}),
    );
  });

  test('UseCaseResult `onData` is called in `when` method', () {
    var result = UseCaseResult.Success(data: "Called");
    result.when(
      onData: expectAsync1((e) {}),
      onError: neverCalled,
    );
  });
}

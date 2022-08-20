// Mocks generated by Mockito 5.3.0 from annotations
// in mobile/test/app/domain/usecases/list_prediction/list_prediction.usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mobile/app/domain/entities/prediction.dart' as _i6;
import 'package:mobile/app/domain/entities/prediction_payload.dart' as _i7;
import 'package:mobile/app/domain/interfaces/services/i_predictions_service.dart'
    as _i3;
import 'package:mobile/errors/errors.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [IPredictionsService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIPredictionsService extends _i1.Mock
    implements _i3.IPredictionsService {
  MockIPredictionsService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Prediction>>> listPredictions() =>
      (super.noSuchMethod(Invocation.method(#listPredictions, []),
          returnValue:
              _i4.Future<_i2.Either<_i5.Failure, List<_i6.Prediction>>>.value(
                  _FakeEither_0<_i5.Failure, List<_i6.Prediction>>(
                      this, Invocation.method(#listPredictions, [])))) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Prediction>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Prediction>> predictDisease(
          {_i7.PredictionPayload? payload}) =>
      (super.noSuchMethod(
          Invocation.method(#predictDisease, [], {#payload: payload}),
          returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Prediction>>.value(
              _FakeEither_0<_i5.Failure, _i6.Prediction>(this,
                  Invocation.method(#predictDisease, [], {#payload: payload})))) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.Prediction>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Prediction>> getPrediction(
          {String? id}) =>
      (super.noSuchMethod(Invocation.method(#getPrediction, [], {#id: id}),
              returnValue:
                  _i4.Future<_i2.Either<_i5.Failure, _i6.Prediction>>.value(
                      _FakeEither_0<_i5.Failure, _i6.Prediction>(this,
                          Invocation.method(#getPrediction, [], {#id: id}))))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.Prediction>>);
}

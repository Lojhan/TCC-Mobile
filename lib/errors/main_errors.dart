class Failure implements Exception {
  toJson() {
    return {};
  }

  fromJson(Map<String, dynamic> json) {
    return this;
  }
}

class NotPredictedFailure extends Failure {}

class FailedToPredictError extends Failure {}

class FailedToLoadPredictionsError extends Failure {}

class FailedToLoadPredictionError extends Failure {}

class InvalidPredictionPayloadError extends Failure {}

class NoCamerasAvailableException extends Failure {}

class CameraPremissionException extends Failure {}

class TimeoutFailure extends Failure {}

class UnauthorizedError extends Failure {}

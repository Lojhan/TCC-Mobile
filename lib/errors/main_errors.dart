class Failure implements Exception {}

class FailedToPredictError extends Failure {}

class FailedToLoadPredictionsError extends Failure {}

class FailedToLoadPredictionError extends Failure {}

class InvalidPredictionPayloadError extends Failure {}

class NoCamerasAvailableException extends Failure {}

class CameraPremissionException extends Failure {}

class TimeoutFailure extends Failure {}

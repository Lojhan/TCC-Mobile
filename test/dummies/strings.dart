import 'predictions.dart';

class StringDummy {
  static get predictionRemoteJsonPayload {
    return {
      'id': id,
      'remoteImagePath': remoteImagePath,
      'dx': dx,
      'diseaseName': diseaseName,
      'createdAt': date,
      'predicted': true,
    };
  }

  static get predictionLocalJsonPayload {
    return perfectPrediction.toJson;
  }

  static get base64String => 'cGF5bG9hZA==';
  static get notBase64String => 'payload';

  static get filePath => 'generated/hello_world.dart';

  static get remoteImagePath => 'remoteImagePath';
  static get localImagePath => filePath;

  static get diseaseName => 'diseaseName';

  static get dx => 'dx';

  static get id => 'id';

  static get date => '2020-01-01';

  static get baseUrl => 'http://localhost:8080';

  static get fileName => 'hello_world.dart';
}

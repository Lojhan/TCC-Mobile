class StringDummy {
  static get predictionRemoteJsonPayload {
    return {
      'id': '1',
      'remoteImagePath': '',
      'dx': 'dx',
      'diseaseName': 'diseaseName',
    };
  }

  static get predictionLocalJsonPayload {
    return {
      'id': '1',
      'localImagePath': '',
      'dx': 'dx',
      'diseaseName': 'diseaseName',
    };
  }

  static get base64String => 'cGF5bG9hZA==';
  static get notBase64String => 'payload';

  static get filePath => 'generated/hello_world.dart';

  static get remoteImagePath => 'remoteImagePath';
  static get localImagePath => 'localImagePath';

  static get diseaseName => 'diseaseName';

  static get dx => 'dx';

  static get id => 'id';

  static get date => '2020-01-01';
}

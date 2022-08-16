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
}

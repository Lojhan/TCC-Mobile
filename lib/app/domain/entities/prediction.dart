class Prediction {
  final String id;
  final String? localImagePath;
  final String? remoteImagePath;
  final String dx;
  final String diseaseName;

  get image => localImagePath != null && localImagePath!.isNotEmpty
      ? localImagePath
      : remoteImagePath;

  Prediction({
    required this.id,
    this.localImagePath,
    this.remoteImagePath,
    required this.dx,
    required this.diseaseName,
  });

  factory Prediction.fromRemote(Map<String, dynamic> json) {
    return Prediction(
      id: json['id'],
      remoteImagePath: json['remoteImagePath'],
      dx: json['dx'],
      diseaseName: json['diseaseName'],
    );
  }

  factory Prediction.fromLocal(Map<String, dynamic> json) {
    return Prediction(
      id: json['id'],
      localImagePath: json['localImagePath'],
      dx: json['dx'],
      diseaseName: json['diseaseName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'localImagePath': localImagePath,
      'remoteImagePath': remoteImagePath,
      'dx': dx,
      'diseaseName': diseaseName,
    };
  }

  bool renderable() {
    if (id.isEmpty) {
      return false;
    }

    if (dx.isEmpty) {
      return false;
    }

    if (diseaseName.isEmpty) {
      return false;
    }

    if (localImagePath == null && remoteImagePath == null) {
      return false;
    }

    if (localImagePath != null && remoteImagePath != null) {
      if (localImagePath!.isEmpty && remoteImagePath!.isEmpty) {
        return false;
      }
    }

    return true;
  }
}

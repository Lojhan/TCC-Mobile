import 'package:mobile/app/main/domain/entities/prediction.dart';

import 'strings.dart';

Prediction perfectPrediction = Prediction(
  id: StringDummy.id,
  localImagePath: StringDummy.localImagePath,
  remoteImagePath: StringDummy.remoteImagePath,
  dx: StringDummy.dx,
  diseaseName: StringDummy.diseaseName,
  createdAt: DateTime.parse(StringDummy.date),
  predicted: true,
  validated: true,
);

Prediction predWithoutId = Prediction(
  id: StringDummy.id,
  localImagePath: StringDummy.localImagePath,
  remoteImagePath: StringDummy.remoteImagePath,
  dx: StringDummy.dx,
  diseaseName: StringDummy.diseaseName,
  createdAt: DateTime.parse(StringDummy.date),
  predicted: true,
  validated: true,
);

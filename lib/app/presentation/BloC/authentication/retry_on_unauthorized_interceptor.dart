import 'package:dio/dio.dart';
import 'package:mobile/app/authentication/domain/models/providers_enum.dart';
import 'package:mobile/app/presentation/BloC/authentication/authentication_bloc.dart';
import 'package:mobile/helpers/extended_multipart.dart';

Future<void Function(DioError p1, ErrorInterceptorHandler p2)?>
    retryOnUnautorized(
  Dio dioInstance,
  AuthenticationProvider provider,
  Function getAuth,
  Function(AuthenticationEvent) add,
) async {
  return (
    DioError e,
    ErrorInterceptorHandler handler,
  ) async {
    if ([401, 403].contains(e.response?.statusCode)) {
      final result = await getAuth();
      AuthenticationState auth = result.fold(
        (l) => AuthenticationState.failure(l),
        (r) => AuthenticationState.login(r, provider),
      );

      if (auth.failure != null) {
        handler.next(e);
      } else {
        int? retries = int.tryParse(e.requestOptions.headers['retries'] ?? '0');
        retries ??= 0;

        if (retries == 3) {
          add(AuthenticationSignOutEvent(provider: provider));
          handler.resolve(Response(requestOptions: e.requestOptions));
        }

        Options options = Options(
          headers: {
            'Authorization': 'Bearer ${auth.user?.token}',
            'Retries': (retries + 1).toString(),
          },
          method: e.requestOptions.method,
        );
        try {
          final oldData = e.requestOptions.data;

          final formData = FormData();
          formData.fields.addAll(oldData.fields);

          for (MapEntry entry in oldData.files) {
            MultipartFileExtended oldFile = entry.value;
            final newFile = MultipartFileExtended.fromFileSync(
              oldFile.filePath,
              filename: oldFile.filename!,
              contentType: oldFile.contentType!,
            );

            formData.files.add(MapEntry(entry.key, newFile));
          }
          final response = await dioInstance.request(
            e.requestOptions.path,
            options: options,
            data: formData,
          );

          handler.resolve(response);
          add(AuthenticationRenewEvent(state: auth));
        } on DioError {
          if (!handler.isCompleted) {
            handler.next(e);
          }

          add(AuthenticationSignOutEvent(provider: provider));
        }
      }
    } else {
      if (!handler.isCompleted) {
        handler.next(e);
      }
    }
  };
}

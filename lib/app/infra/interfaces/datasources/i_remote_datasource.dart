import 'dart:async';

abstract class IRemoteDatasource<T> {
  FutureOr<List<T>?> list();
  FutureOr<T?> getById(String id);
  FutureOr<T?> save(T model);
  FutureOr<T?> update(T model);
  FutureOr<T?> delete(String id);
}

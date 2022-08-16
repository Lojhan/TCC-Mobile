import 'dart:async';

abstract class ILocalDatasource<T> {
  FutureOr<List<T>> list();
  FutureOr<T> getById(String id);
  FutureOr<void> save(T model);
  FutureOr<void> update(T model);
  FutureOr<void> delete(String id);
}

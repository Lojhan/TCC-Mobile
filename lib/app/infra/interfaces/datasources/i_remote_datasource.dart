abstract class IRemoteDatasource<T> {
  Future<List<T>> list();
  Future<T> getById(String id);
  Future<T> save(T model);
  Future<T> update(T model);
  Future<T> delete(String id);
}

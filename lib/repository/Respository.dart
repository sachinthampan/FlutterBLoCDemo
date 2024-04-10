abstract class Repository<T>{
  Future<T> insert (T data);
  Future<T> read (T id);
  Future<T> readAll ();
  Future<T> update (T id, T data);
  Future<T> delete (T id);
}
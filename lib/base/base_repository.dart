import 'package:octopush/base/base_dao.dart';

import 'base_entity.dart';

abstract class BaseRepository<T extends BaseEntity, D extends BaseDao> {
  final D _dao;

  BaseRepository(this._dao);

  Future<List<T>> getAll() => _dao.getAll();

  Future<T> findByPrimaryKey(int id) => _dao.findByPrimaryKey(id);

  Future<int> update(T entity) => _dao.update(entity);

  Future<int> add(T entity) => _dao.add(entity);
}

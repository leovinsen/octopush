import 'package:octopush/database/challenge_dao.dart';
import 'package:octopush/model/challenge.dart';

class ChallengeRepository {
  final ChallengeDao _dao = ChallengeDao();

  Future<List<Challenge>> getAll() => _dao.getAll();
  
  Future<Challenge> getOne(int timeInterval) => _dao.getOne(timeInterval);

  Future<int> update(Challenge c) => _dao.update(c);

  Future<int> add(Challenge c) => _dao.add(c);

}
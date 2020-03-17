
import '../../data/models/User.dart';

abstract class UserService {
  Future<User> save(User user, String password);
  Future<User> findById(String userId);
  Future<User> update(User user);
}
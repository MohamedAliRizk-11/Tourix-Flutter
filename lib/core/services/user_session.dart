import '../../features/auth/models/user_model.dart';

class UserSession {
  UserSession._internal();
  static final UserSession instance = UserSession._internal();

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  void setUser(UserModel user) => _currentUser = user;
  void clear() => _currentUser = null;
}

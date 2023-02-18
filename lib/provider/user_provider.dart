import 'package:flutter/foundation.dart';
import 'package:weather/models/user_model.dart';

class UserProvider with ChangeNotifier {
  bool refresh = false;
  UserModel? user;

  bool get isRefresh => refresh;

  UserModel? get userAuth => user;

  void setUser(UserModel value) {
    user = value;
    notifyListeners();
  }

  void setRefresh(bool value) {
    refresh = value;
    notifyListeners();
  }
}

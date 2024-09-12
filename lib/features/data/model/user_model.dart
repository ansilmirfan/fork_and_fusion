import 'package:fork_and_fusion/features/domain/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class UserModel extends UserEntity {
  UserModel(
      {required super.userName,
      required super.email,
      required super.userId,
      super.image});
  factory UserModel.fromFireBaseUser(firebase_auth.User user) {
    return UserModel(
        userName: user.displayName ?? '',
        email: user.email ?? '',
        userId: user.uid,
        image: user.photoURL);
  }
}

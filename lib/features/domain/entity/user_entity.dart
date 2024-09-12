class UserEntity {
  final String userName;
  final String email;
  final String userId;
  String? image;

  UserEntity(
      {required this.userName,
      required this.email,
      required this.userId,
      this.image});
}

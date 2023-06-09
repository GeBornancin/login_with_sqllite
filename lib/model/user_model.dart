class UserModel {
  String userId;
  String userName;
  String userEmail;
  String userPassword;

  UserModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
  });



  @override
  String toString() {
    return 'UserModel(userId: $userId, userName: $userName, userEmail: $userEmail, userPassword: $userPassword)';
  }
}

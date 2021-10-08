class User{
  int id;
  String userName;
  String password;

  userMap(){
    var mapping=Map<String,dynamic>();
    mapping['id']=id;
    mapping['username']=userName;
    mapping['password']=password;

    return mapping;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User &&
              runtimeType == other.runtimeType &&
              userName == other.userName &&
              password == other.password;

  @override
  int get hashCode =>
      userName.hashCode ^
      password.hashCode;

  @override
  String toString() {
    return 'User{id: $id, userName: $userName, password: $password}';
  }

}
class Users{
  final String userId;
  final String userPassword;

  Users({
    required this.userId,
    required this.userPassword
});
  factory
      Users.fromMap(Map<dynamic,dynamic>json){
    return Users(
      userId: json['userId'],
      userPassword: json['userPassword']
    );
  }
  Map<String,dynamic>toMap(){
    return{
      'userId':userId,
      'userPassword':userPassword
    };
  }

}
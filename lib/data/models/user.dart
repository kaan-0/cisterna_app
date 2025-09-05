
class User {
    final int responseCode;
    final String status;
    final String message;
    final UserInfo userInfo;
    final String token;
    final String tokenType;

    User({
        required this.responseCode,
        required this.status,
        required this.message,
        required this.userInfo,
        required this.token,
        required this.tokenType,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        responseCode: json["response_code"],
        status: json["status"],
        message: json["message"],
        userInfo: UserInfo.fromJson(json["user_info"]),
        token: json["token"],
        tokenType: json["token_type"],
    );

    Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "status": status,
        "message": message,
        "user_info": userInfo.toJson(),
        "token": token,
        "token_type": tokenType,
    };
}

class UserInfo {
    final int id;
    final String name;
    final String email;

    UserInfo({
        required this.id,
        required this.name,
        required this.email,
    });

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
    };
}

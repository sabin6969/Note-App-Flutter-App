class LoginResponse {
  LoginResponse({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.sucess,
  });

  final int? statusCode;
  final Data? data;
  final String? message;
  final bool? sucess;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      statusCode: json["statusCode"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      message: json["message"],
      sucess: json["sucess"],
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data?.toJson(),
        "message": message,
        "sucess": sucess,
      };
}

class Data {
  Data({
    required this.id,
    required this.fullName,
    required this.email,
    required this.profileImageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.refreshToken,
    required this.accessToken,
  });

  final String? id;
  final String? fullName;
  final String? email;
  final String? profileImageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? refreshToken;
  final String? accessToken;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["_id"],
      fullName: json["fullName"],
      email: json["email"],
      profileImageUrl: json["profileImageUrl"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      refreshToken: json["refreshToken"],
      accessToken: json["accessToken"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "email": email,
        "profileImageUrl": profileImageUrl,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "refreshToken": refreshToken,
        "accessToken": accessToken,
      };
}

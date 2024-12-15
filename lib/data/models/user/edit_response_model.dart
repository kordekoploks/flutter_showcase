import 'dart:convert';

import 'user_model.dart';

EditUserResponseModel editUserResponseModelFromJson(String str) =>
    EditUserResponseModel.fromJson(json.decode(str));

String editUserResponseModelToJson(EditUserResponseModel data) =>
    json.encode(data.toJson());

class EditUserResponseModel {
  final UserModel user;

  const EditUserResponseModel({
    required this.user,
  });

  factory EditUserResponseModel.fromJson(Map<String, dynamic> json) =>
      EditUserResponseModel(
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}



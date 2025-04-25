import 'package:json_annotation/json_annotation.dart';
import 'package:notepad/data/model/enum_model.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  final String name;
  final String phone;
  final String avatar;
  final Sex sex;

  UserInfo(
    this.sex, {
    required this.avatar,
    required this.name,
    required this.phone,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

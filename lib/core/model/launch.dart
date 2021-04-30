import 'package:json_annotation/json_annotation.dart';

part 'launch.g.dart';

@JsonSerializable(checked: true)
class Launch {
  String name;

  Launch({this.name});

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);
}
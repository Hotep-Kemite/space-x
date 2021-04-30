// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Launch _$LaunchFromJson(Map<String, dynamic> json) {
  return $checkedNew('Launch', json, () {
    final val = Launch(
      name: $checkedConvert(json, 'name', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$LaunchToJson(Launch instance) => <String, dynamic>{
      'name': instance.name,
    };

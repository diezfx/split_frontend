// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnvConfig _$EnvConfigFromJson(Map<String, dynamic> json) => EnvConfig(
      json['baseUrl'] as String,
      json['splitrBackendUrl'] as String,
      SupaBaseConfig.fromJson(json['supabase'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EnvConfigToJson(EnvConfig instance) => <String, dynamic>{
      'baseUrl': instance.baseUrl,
      'splitrBackendUrl': instance.splitrBackendUrl,
      'supabase': instance.supabase,
    };

SupaBaseConfig _$SupaBaseConfigFromJson(Map<String, dynamic> json) =>
    SupaBaseConfig(
      json['url'] as String,
      json['anonKey'] as String,
    );

Map<String, dynamic> _$SupaBaseConfigToJson(SupaBaseConfig instance) =>
    <String, dynamic>{
      'url': instance.url,
      'anonKey': instance.anonKey,
    };

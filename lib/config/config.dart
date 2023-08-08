import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class EnvConfig {
  String splitrBackendUrl;

  EnvConfig(this.splitrBackendUrl);

  static Future<EnvConfig> loadConfig() async {
    var configContent = await rootBundle.loadString('assets/config/dev.json');

    var configJson = jsonDecode(configContent);

    return EnvConfig.fromJson(configJson);
  }

  /// Connect the generated [_$EnvConfig] function to the `fromJson`
  /// factory.
  factory EnvConfig.fromJson(Map<String, dynamic> json) =>
      _$EnvConfigFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$EnvConfigToJson(this);
}

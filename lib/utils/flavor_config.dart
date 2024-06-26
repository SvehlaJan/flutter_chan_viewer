import 'package:flutter/material.dart';
import 'package:flutter_chan_viewer/utils/extensions.dart';

/// Original - https://pub.dev/packages/flutter_snow_base
class FlavorConfig {
  final Flavor _flavor;
  final String _name;
  final Color _color;
  final FlavorValues _values;
  static FlavorConfig? _instance;

  factory FlavorConfig({required Flavor flavor, Color color = Colors.blue, required FlavorValues values}) {
    _instance ??= FlavorConfig._internal(flavor, flavor.toString().getNameFromEnum(), color, values);
    return _instance!;
  }

  @visibleForTesting
  factory FlavorConfig.tests({required Flavor flavor, Color color = Colors.blue, required FlavorValues values}) {
    _instance = FlavorConfig._internal(flavor, flavor.toString().getNameFromEnum(), color, values);
    return _instance!;
  }

  factory FlavorConfig.defaults({required FlavorValues values}) {
    _instance ??= FlavorConfig._internal(Flavor.dev, Flavor.dev.toString().getNameFromEnum(), Colors.blue, values);
    return _instance!;
  }

  FlavorConfig._internal(this._flavor, this._name, this._color, this._values);

  static bool get isProduction => _instance!._flavor == Flavor.production;

  static bool get isDevelopment => _instance!._flavor == Flavor.dev;

  static bool get isQA => _instance!._flavor == Flavor.qa;

  static Flavor get flavor => _instance!._flavor;

  static String get name => _instance!._name;

  static Color get color => _instance!._color;

  static T values<T extends FlavorValues>() => _instance!._values as T;
}

enum Flavor { dev, qa, production }

abstract class FlavorValues {
  final String? baseUrl;
  final String? baseImgUrl;

  FlavorValues({
    this.baseUrl,
    this.baseImgUrl,
  });
}

class FlavorValuesApp implements FlavorValues {
  const FlavorValuesApp({
    required this.baseUrl,
    this.baseImgUrl,
    required Map<String, bool> Function() features,
  }) : _features = features;

  final String baseUrl;
  final String? baseImgUrl;
  final Map<String, bool> Function() _features;

  Map<String, bool> get features => _features();
//Add other flavor specific values, e.g database name
}

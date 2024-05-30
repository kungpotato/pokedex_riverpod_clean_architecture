import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:pokedex/localization/localize.dart';
import 'package:source_gen/source_gen.dart';

class LocalizationGenerator extends GeneratorForAnnotation<Localize> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    const jsonFilePath = 'lib/localization/localization_config.json';
    final jsonContent = await buildStep.readAsString(
      AssetId(buildStep.inputId.package, jsonFilePath),
    );

    final localizationMap = jsonDecode(jsonContent) as Map<String, dynamic>;

    // Generate the Dart code
    final buffer = StringBuffer();
    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    buffer.writeln(
      '// **************************************************************************',
    );
    buffer.writeln('// This file was generated by Kung.kittisak@bitkub.com');
    buffer.writeln(
      '// **************************************************************************',
    );
    buffer.writeln();
    buffer.writeln('class Localization {');
    localizationMap.forEach((key, value) {
      buffer.writeln('  final String $key;');
    });
    buffer.writeln();
    buffer.writeln('  Localization({');
    localizationMap.forEach((key, value) {
      buffer.writeln('    required this.$key,');
    });
    buffer.writeln('  });');
    buffer.writeln();
    buffer.writeln(
      '  factory Localization.fromRemoteConfig(Map<String, String> remoteConfig) {',
    );
    buffer.writeln('    return Localization(');
    localizationMap.forEach((key, value) {
      buffer.writeln('      $key: remoteConfig["$key"] ?? "$value",');
    });
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }
}

import 'package:build/build.dart';
import 'package:pokedex/localization/localization_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder localizationBuilder(BuilderOptions options) =>
    SharedPartBuilder([LocalizationGenerator()], 'localization');

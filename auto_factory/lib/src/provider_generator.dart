import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Base class extended by [FactoryGenerator] and [CachingFactoryGenerator]
abstract class BaseFactoryGenerator<T> extends GeneratorForAnnotation<T> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader reader,
    BuildStep buildStep,
  ) {
    if (element is ClassElement) {
      final ctor =
          element.constructors.firstWhere((ctor) => ctor.displayName == '');

      final declarations = ctor.parameters
          .map((param) => param.type)
          .map(_declaration)
          .join('\n');

      final params =
          ctor.parameters.map((param) => param.type).map(_parameter).join(' ');
      return _finalize(element, declarations, params);
    }
    return '';
  }

  String _declaration(DartType type);
  String _parameter(DartType type);
  String _finalize(
    ClassElement element,
    String declarations,
    String params,
  );
}

/// Generates a factory shared part for classes annotated with [AutoFactory].
/// After creating an instance, the method get provides the required type and its dependencies
class FactoryGenerator extends BaseFactoryGenerator<AutoFactory> {
  @override
  String _declaration(DartType type) =>
      'final ${_typeToInstanceName(type)}Factory = ${type}Factory();';

  @override
  String _parameter(DartType type) =>
      '${_typeToInstanceName(type)}Factory.get(),';

  @override
  String _finalize(ClassElement element, String declarations, String params) =>
      '''
      class ${element.displayName}Factory {

        ${element.displayName} get() {

          $declarations

          return ${element.displayName}($params);
        }
      }
      ''';
}

/// Generates a caching factory shared part for classes annotated with [CachingFactory].
/// This is the same as [AutoFactory] but the instance is cached
class CachingFactoryGenerator extends BaseFactoryGenerator<CachingFactory> {
  @override
  String _declaration(DartType type) =>
      'final ${_typeToInstanceName(type)}Factory = ${type}Factory();';

  @override
  String _parameter(DartType type) {
    return '${_typeToInstanceName(type)}Factory.get(),';
  }

  @override
  String _finalize(ClassElement element, String declarations, String params) =>
      '''
      class ${element.displayName}Factory {

        ${element.displayName} instance;

        ${element.displayName} get() {
          $declarations

          instance ??= ${element.displayName}(
            $params
          );

          return instance;
        }
      }
      ''';
}

String _typeToInstanceName(DartType type) {
  final typeAsString = type.toString();
  return typeAsString[0].toLowerCase() + typeAsString.substring(1);
}

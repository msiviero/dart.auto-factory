import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/* 
 * Base class extended by [FactoryGenerator] and [CachingFactoryGenerator] 
 */
abstract class BaseFactoryGenerator<T> extends GeneratorForAnnotation<T> {
  final TypeChecker _providedChecker = TypeChecker.fromRuntime(Provided);

  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader reader,
    BuildStep buildStep,
  ) {
    if (element is ClassElement) {
      final declarations = element.unnamedConstructor.parameters
          .map(_generateDeclaration)
          .join('\n');

      final params = element.unnamedConstructor.parameters
          .map(_generateParamater)
          .join(' ');

      return _finalize(element, declarations, params);
    }
    return '';
  }

  bool _hasProvidedAnnotation(ParameterElement parameter) =>
      _providedChecker.hasAnnotationOfExact(parameter);

  String _generateDeclaration(ParameterElement element) => _hasProvidedAnnotation(
          element)
      ? ''
      : 'final ${_typeToInstanceName(element.type)}Factory = ${_typeToString(element.type)}Factory();';

  String _generateParamater(ParameterElement element) {
    if (_hasProvidedAnnotation(element)) {
      final MethodElement providerMethod = _providedChecker
          .firstAnnotationOfExact(element)
          .getField('provider')
          .toFunctionValue();

      final methodParams =
          providerMethod.parameters.map(_generateParamater).join(' ');

      return 'await ${providerMethod.enclosingElement.name}.${providerMethod.name}($methodParams),';
    }
    return 'await ${_typeToInstanceName(element.type)}Factory.create(),';
  }

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
  String _finalize(ClassElement element, String declarations, String params) =>
      '''
      class ${element.name}Factory {

        Future<${element.name}> create() async {

          $declarations

          return ${element.name}($params);
        }
      }
      ''';
}

/// Generates a caching factory shared part for classes annotated with [CachingFactory].
/// This is the same as [AutoFactory] but the instance is cached
class CachingFactoryGenerator extends BaseFactoryGenerator<CachingFactory> {
  @override
  @override
  String _finalize(ClassElement element, String declarations, String params) =>
      '''
      class ${element.name}Factory {

        static final ${element.name}Factory _singleton = ${element.name}Factory._internal();

        factory ${element.name}Factory() {
          return _singleton;
        }

        ${element.name}Factory._internal();

        ${element.name} _objectInstance;

        Future<${element.name}> create() async {
          $declarations

          _objectInstance ??= ${element.name}(
            $params
          );

          return _objectInstance;
        }
      }
      ''';
}

String _typeToString(DartType type) {
  return type.element.name;
}

String _typeToInstanceName(DartType type) {
  final typeAsString = type.element.name;
  return typeAsString[0].toLowerCase() + typeAsString.substring(1);
}

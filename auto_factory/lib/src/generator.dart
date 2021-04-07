import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class GeneratorUtils {
  static final TypeChecker _providedByAnnotationChecker =
      TypeChecker.fromRuntime(ProvidedBy);

  static bool hasProvidedByAnnotation(ParameterElement parameter) =>
      _providedByAnnotationChecker.hasAnnotationOfExact(parameter);

  static DartType computeParameterType(ParameterElement parameter) =>
      _providedByAnnotationChecker
          .firstAnnotationOfExact(parameter)
          ?.getField('provider')
          ?.toTypeValue() ??
      parameter.type;

  static String typeString(DartType type) => type.element!.name ?? '';

  static String typeInstance(DartType type) {
    final typeAsString = type.element!.name;
    return typeAsString![0].toLowerCase() + typeAsString.substring(1);
  }

  static String generateDeclaration(ParameterElement parameter) {
    final type = GeneratorUtils.computeParameterType(parameter);
    final instanceName = GeneratorUtils.typeInstance(type);
    final typeName = GeneratorUtils.typeString(type);
    return 'final ${instanceName}Factory = ${typeName}Factory();';
  }

  static String generateParameter(
    ParameterElement element,
    bool asyncMode,
  ) {
    final type = GeneratorUtils.computeParameterType(element);
    final instanceName = GeneratorUtils.typeInstance(type);

    if (asyncMode) {
      return hasProvidedByAnnotation(element)
          ? 'await (await ${instanceName}Factory.create()).provide(),'
          : 'await ${instanceName}Factory.create(),';
    } else {
      return hasProvidedByAnnotation(element)
          ? '${instanceName}Factory.create().provide(),'
          : '${instanceName}Factory.create(),';
    }
  }

  static String returnType(String name, bool asyncMode) =>
      asyncMode ? 'Future<$name>' : name;

  static String asyncModifier(bool asyncMode) => asyncMode ? 'async' : '';
}

/// Generates a factory shared part for classes annotated with [Injectable].
/// After creating an instance, the method create provides the required type and its dependencies
class InjectableGenerator extends GeneratorForAnnotation<Injectable> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      return '';
    }

    final asyncMode = annotation.read('asyncMode').boolValue;

    final declarations = element.unnamedConstructor!.parameters
        .map(GeneratorUtils.generateDeclaration)
        .join('\n');

    final params = element.unnamedConstructor!.parameters
        .map((it) => GeneratorUtils.generateParameter(it, asyncMode))
        .join('\n');

    final name = element.name;

    return '''
      class ${name}Factory {

        ${GeneratorUtils.returnType(name, asyncMode)} create() ${GeneratorUtils.asyncModifier(asyncMode)} {

          $declarations

          return $name($params);
        }
      }
      ''';
  }
}

// Generates a caching factory shared part for classes annotated with [Singleton].
/// This is the same as [Injectable] but the instance is cached
class SingletonFactoryGenerator extends GeneratorForAnnotation<Singleton> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      return '';
    }
    final asyncMode = annotation.read('asyncMode').boolValue;

    final declarations = element.unnamedConstructor!.parameters
        .map(GeneratorUtils.generateDeclaration)
        .join('\n');

    final params = element.unnamedConstructor!.parameters
        .map((it) => GeneratorUtils.generateParameter(it, asyncMode))
        .join('\n');

    final name = element.name;

    return '''
      class ${name}Factory {

        static final ${name}Factory _singleton = ${name}Factory._internal();

        factory ${name}Factory() {
          return _singleton;
        }

        ${name}Factory._internal();

        $name? _objectInstance;

        ${GeneratorUtils.returnType(name, asyncMode)} create() ${GeneratorUtils.asyncModifier(asyncMode)} {
          $declarations

          _objectInstance ??= $name(
            $params
          );

          return _objectInstance!;
        }
      }
      ''';
  }
}

/// Generates a provider implementation for classes annotated with [Provider].
/// After creating an instance, the method get provides the required type and its dependencies
class ProviderGenerator extends GeneratorForAnnotation<Provider> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      return '';
    }
    final asyncMode = annotation.read('asyncMode').boolValue;

    final declarations = element.unnamedConstructor!.parameters
        .map(GeneratorUtils.generateDeclaration)
        .join('\n');

    final params = element.unnamedConstructor!.parameters
        .map((it) => GeneratorUtils.generateParameter(it, asyncMode))
        .join('\n');

    final name = element.name;

    return '''
      class ${name}Factory {

        static final ${name}Factory _singleton = ${name}Factory._internal();

        factory ${name}Factory() {
          return _singleton;
        }

        ${name}Factory._internal();

        $name? _objectInstance;

        ${GeneratorUtils.returnType(name, asyncMode)} create() ${GeneratorUtils.asyncModifier(asyncMode)} {
          $declarations

          _objectInstance ??= $name(
            $params
          );

          return _objectInstance!;
        }
      }
      ''';
  }
}

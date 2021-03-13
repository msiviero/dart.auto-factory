// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// ProviderGenerator
// **************************************************************************

class StringDependencyProviderFactory {
  static final StringDependencyProviderFactory _singleton =
      StringDependencyProviderFactory._internal();

  factory StringDependencyProviderFactory() {
    return _singleton;
  }

  StringDependencyProviderFactory._internal();

  StringDependencyProvider _objectInstance;

  Future<StringDependencyProvider> create() async {
    final helloServiceFactory = HelloServiceFactory();

    _objectInstance ??= StringDependencyProvider(
      await helloServiceFactory.create(),
    );

    return _objectInstance;
  }
}

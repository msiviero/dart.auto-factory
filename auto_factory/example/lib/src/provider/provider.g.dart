// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// ProviderGenerator
// **************************************************************************

class HelloServiceProviderFactory {
  static final HelloServiceProviderFactory _singleton =
      HelloServiceProviderFactory._internal();

  factory HelloServiceProviderFactory() {
    return _singleton;
  }

  HelloServiceProviderFactory._internal();

  HelloServiceProvider? _objectInstance;

  Future<HelloServiceProvider> create() async {
    final helloServiceFactory = HelloServiceFactory();
    final nameProviderFactory = NameProviderFactory();

    _objectInstance ??= HelloServiceProvider(
      await helloServiceFactory.create(),
      await (await nameProviderFactory.create()).provide(),
    );

    return _objectInstance!;
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hello_service.dart';

// **************************************************************************
// CachingFactoryGenerator
// **************************************************************************

class HelloServiceFactory {
  static final HelloServiceFactory _singleton = HelloServiceFactory._internal();

  factory HelloServiceFactory() {
    return _singleton;
  }

  HelloServiceFactory._internal();

  HelloService? _objectInstance;

  Future<HelloService> create() async {
    _objectInstance ??= HelloService();

    return _objectInstance!;
  }
}

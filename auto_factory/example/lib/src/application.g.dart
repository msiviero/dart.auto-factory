// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application.dart';

// **************************************************************************
// FactoryGenerator
// **************************************************************************

class ApplicationFactory {
  Future<Application> create() async {
    final helloServiceFactory = HelloServiceFactory();

    return Application(
      await helloServiceFactory.create(),
      await StringDependencyProvider.provideString(),
    );
  }
}

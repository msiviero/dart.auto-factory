// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application.dart';

// **************************************************************************
// FactoryGenerator
// **************************************************************************

class ApplicationFactory {
  Future<Application> create() async {
    final helloServiceFactory = HelloServiceFactory();
    final stringDependencyProviderImpl = StringDependencyProviderImpl();

    return Application(
      await helloServiceFactory.create(),
      await stringDependencyProviderImpl.provide(),
    );
  }
}

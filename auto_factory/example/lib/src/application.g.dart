// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application.dart';

// **************************************************************************
// FactoryGenerator
// **************************************************************************

class ApplicationFactory {
  Future<Application> create() async {
    final helloServiceFactory = HelloServiceFactory();
    final stringDependencyProviderFactory = StringDependencyProviderFactory();

    return Application(
      await helloServiceFactory.create(),
      await (await stringDependencyProviderFactory.create()).provide(),
    );
  }
}

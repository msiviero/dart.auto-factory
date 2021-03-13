Compile time dependency injection using factories, implmented using [_source_gen_](https://pub.dev/packages/source_gen) package, so that it works in every platform.
The advantages of this approach are are performance (no reflection needed) and full debuggability, as the generated sources are easy to read and well formatted.

## Install

To use this package, add ```auto_factory``` and ```build_runner``` in the *dev_dependencies* section 
and the ```auto_factory``` package in the *dependencies* section of your pubspec.yaml file.

Then, run ```pub run build_runner build``` to generate the part files.

## Table of contents

- [Basic usage](#basic-usage)
- [Singletons](#singletons)
- [Providers](#providers)
- [Example](#example)

## Basic usage

To make a class part of the dependecy tree annotate the class with the *@Injectable()* annotation. The library satisfies the dependency by creating a new instance and injecting to the default constructor the required dependencies.

Note that the injection will work only on default constructor with positional arguments. See [example](https://github.com/msiviero/dart.auto-factory/tree/master/auto_factory/example) directory.

```dart
import 'package:auto_factory_annotation/auto_factory_annotation.dart';

part 'myfile.g.dart';

@Injectable()
class Component {
  final OtherDependency dep;

  Component(OtherDependency this.dep);

  void doSomething() {
    //...
  }
}

/// in another file:
final component = ComponentFactory().create();

component.doSomething();
```
## Singletons

Using the *@Singleton()* annotation has the same effect as *@Component()*
except that the instance is only created the first time. Then the same instance is returned every time

```dart
import 'package:auto_factory_annotation/auto_factory_annotation.dart';

part 'myfile.g.dart';

@Singleton()
class Component {
  final OtherDependency dep;

  Component(OtherDependency this.dep);

  void doSomething() {
    //...
  }
}

/// in another file:
final component = ComponentFactory().create();

component.doSomething();
```

## Providers

Sometimes you don't have access to imported objects, so you can't annotate them to make it part of your dependency graph.
In this case you can create a class annotated with *@Provider()* that extends *@ProviderBase<T>* and implement the *provide()* method

```dart
import 'package:auto_factory_annotation/auto_factory_annotation.dart';

part 'myfile.g.dart';

@Provider()
class IpProvider extends ProviderBase<String> {

  @override
  FutureOr<String> provide() {
    return '127.0.0.1';
  }
}
```

And then mark the injected field with the *@ProvidedBy()* annotation like this:

```dart
import 'package:auto_factory_annotation/auto_factory_annotation.dart';

part 'myfile.g.dart';

@Component()
class Component {
  final String ip;

  Component(@ProvidedBy(IpProvider) String this.ip);

  void doSomething() {
    //...
  }
}

/// in another file:
final component = ComponentFactory().create();

component.doSomething();
```

Providers can have their dependencies resolved too with both component and other providers:

```dart
import 'package:auto_factory_annotation/auto_factory_annotation.dart';

part 'myfile.g.dart';

@Provider()
class IpProvider extends ProviderBase<String> {

  final Config config;

  IpProvider(this.config);

  @override
  FutureOr<String> provide() {
    return this.config ? '127.0.0.1' : '11.22.33.44';
  }
}
```

## Example

The *auto_factory/example* directory contains a full example

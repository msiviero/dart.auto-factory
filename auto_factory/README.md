Compile ime factories, implmented using [_source_gen_](https://pub.dev/packages/source_gen) package, so that it works in every platform.
The advantages of this approach are are performance (no reflection needed) and full debuggability, as the generated sources are easy to read and well formatted.
The development principle is to keep it simple, so only the basics features are implemented.

## Install

To use this package, add ```auto_factory``` and ```build_runner``` as a dependency in your pubspec.yaml file.

Then, run ```pub run build_runner build``` to generate the part files.

## Table of contents

- [Create a factory](#create-a-factory)
- [Caching factories](#caching-factories)

## Create a factory

To make a class part of the dependecy tree annotate the class with the *@Component()* annotation. The library satisfies the dependency by creating a new instance and injecting to the default constructor the required dependencies.

Note that the injection will work only on default constructor with positional arguments. See [example](https://github.com/msiviero/dart.auto-factory/tree/master/auto_factory/example) directory.

```dart
import 'package:auto_factory/annotations.dart';

part 'myfile.g.dart';

@AutoFactory()
class Component {
  final OtherDependency dep;

  Component(OtherDependency this.dep);
}

/// in another file:
final component = ComponentFactory().get();

component.doSomething();
```
## Caching factories

Using the *@CachingFactory()* annotation has the same effect as *@AutoFactory()*
except that the instance is only created the first time. Then the same instance is returned every time

import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:source_gen_test/annotations.dart';

import '_basic_dep.dart';
import '_basic_provider.dart';
import '_basic_third_dep.dart';

@ShouldGenerate('''
class MyComponentFactory {
  static final MyComponentFactory _singleton = MyComponentFactory._internal();

  factory MyComponentFactory() {
    return _singleton;
  }

  MyComponentFactory._internal();

  MyComponent _objectInstance;

  Future<MyComponent> create() async {
    final dependencyFactory = DependencyFactory();

    _objectInstance ??= MyComponent(
      await dependencyFactory.create(),
      await ThirdDependencyProvider.provideX(),
    );

    return _objectInstance;
  }
}
''')
@CachingFactory()
class MyComponent {
  final Dependency dep;
  final ThirdDependency third;

  MyComponent(
    this.dep,
    @Provided(ThirdDependencyProvider) this.third,
  );
}

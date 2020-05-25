import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:source_gen_test/annotations.dart';

import '_basic_dep.dart';

@ShouldGenerate('''
class MyComponentFactory {
  MyComponent instance;

  MyComponent get() {
    final dependencyFactory = DependencyFactory();

    instance ??= MyComponent(
      dependencyFactory.get(),
    );

    return instance;
  }
}
''')
@CachingFactory()
class MyComponent {
  final Dependency _dep;

  MyComponent(Dependency dep) : _dep = dep;

  Dependency get dep => _dep;
}

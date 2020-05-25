import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:source_gen_test/annotations.dart';

import '_basic_dep.dart';

@ShouldGenerate('''
class MyComponentFactory {
  MyComponent get() {
    final dependencyFactory = DependencyFactory();

    return MyComponent(
      dependencyFactory.get(),
    );
  }
}
''')
@AutoFactory()
class MyComponent {
  final Dependency _dep;

  MyComponent(Dependency dep) : _dep = dep;

  Dependency get dep => _dep;
}

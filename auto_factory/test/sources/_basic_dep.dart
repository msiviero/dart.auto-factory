import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:source_gen_test/annotations.dart';

import '_basic_second_dep.dart';

@ShouldGenerate('''
class DependencyFactory {
  Dependency get() {
    final secondDependencyFactory = SecondDependencyFactory();

    return Dependency(
      secondDependencyFactory.get(),
    );
  }
}
''')
@AutoFactory()
class Dependency {
  SecondDependency secondDependency;

  Dependency(this.secondDependency);
}

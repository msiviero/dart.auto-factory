import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:source_gen_test/annotations.dart';

import '_basic_dep.dart';
import '_basic_provider.dart';
import '_basic_third_dep.dart';

@ShouldGenerate('''
class MyComponentFactory {
  Future<MyComponent> create() async {
    final dependencyFactory = DependencyFactory();

    return MyComponent(
      await dependencyFactory.create(),
      await ThirdDependencyProvider.provideX(),
    );
  }
}
''')
@AutoFactory()
class MyComponent {
  final Dependency dep;
  final ThirdDependency third;

  MyComponent(
    this.dep,
    @Provided(ThirdDependencyProvider.provideX) this.third,
  );
}

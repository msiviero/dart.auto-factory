import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:source_gen_test/annotations.dart';

import '_sync_dep.dart';
import '_sync_provider.dart';

@ShouldGenerate('''
class MyComponentFactory {
  Future<MyComponent> create() async {
    final dependencyFactory = DependencyFactory();
    final thirdDependencyProviderFactory = ThirdDependencyProviderFactory();

    return MyComponent(
      await dependencyFactory.create(),
      await (await thirdDependencyProviderFactory.create()).provide(),
    );
  }
}
''')
@Injectable()
class MyComponent {
  final Dependency dep;
  final String third;

  MyComponent(
    this.dep,
    @ProvidedBy(ThirdDependencyProvider) this.third,
  );
}

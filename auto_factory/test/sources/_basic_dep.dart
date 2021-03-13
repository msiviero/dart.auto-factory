import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:source_gen_test/annotations.dart';

import '_basic_second_dep.dart';

@ShouldGenerate('''
class DependencyFactory {
  Future<Dependency> create() async {
    final secondDependencyFactory = SecondDependencyFactory();

    return Dependency(
      await secondDependencyFactory.create(),
    );
  }
}
''')
@Injectable()
class Dependency {
  SecondDependency secondDependency;

  Dependency(this.secondDependency);
}

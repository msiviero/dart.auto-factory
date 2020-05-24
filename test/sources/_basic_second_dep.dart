import 'package:auto_factory/annotations.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate('''
class SecondDependencyFactory {
  SecondDependency get() {
    return SecondDependency();
  }
}
''')
@AutoFactory()
class SecondDependency {}

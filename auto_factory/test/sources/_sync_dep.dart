import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate('''
class DependencyFactory {
  Dependency create()  {
    return Dependency();
  }
}
''')
@Injectable()
class Dependency {}

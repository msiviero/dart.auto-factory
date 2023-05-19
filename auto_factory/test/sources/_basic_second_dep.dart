import 'package:auto_factory_annotation/auto_factory_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate('''
class SecondDependencyFactory {
  Future<SecondDependency> create() async {
    return SecondDependency();
  }
}
''')
@Injectable()
class SecondDependency {}

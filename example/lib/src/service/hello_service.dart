import 'package:auto_factory/annotations.dart';

part 'hello_service.g.dart';

@CachingFactory()
class HelloService {
  String who(String name) {
    return name ?? 'World';
  }
}

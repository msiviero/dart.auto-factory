import 'package:auto_factory_annotation/auto_factory_annotation.dart';

part 'hello_service.g.dart';

@Singleton(asyncMode: true)
class HelloService {
  String who(String? name) {
    return name ?? 'World';
  }
}

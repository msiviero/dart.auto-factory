import '_basic_third_dep.dart';

class ThirdDependencyProvider {
  static Future<ThirdDependency> provideX() async {
    return ThirdDependency();
  }
}

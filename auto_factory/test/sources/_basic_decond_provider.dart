import '_basic_third_dep.dart';
import '_fifth_dep.dart';

class FifthDepProvider {
  static Future<FifthDep> provide() async {
    return FifthDep();
  }
}

import 'dart:async';

/// Builds a factory shared part and so makes class injectable
class AutoFactory {
  const AutoFactory();
}

/// Same as Component(), but the class instance is cached
class CachingFactory {
  const CachingFactory();
}

class Provided {
  final ProviderFn provider;
  const Provided(this.provider);
}

typedef ProviderFn = FutureOr<Object> Function();

import 'dart:developer' as lg;

class Logger {
  static final Logger _logger = Logger._internal();

  static Logger get() {
    return _logger;
  }

  Logger._internal();

  void log(Object object) {
    if (!const bool.fromEnvironment("dart.vm.product")) {
      lg.log("Visual Contact Manager : $object");
    }
  }
}

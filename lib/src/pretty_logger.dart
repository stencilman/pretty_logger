import 'package:pretty_logger/src/log_filter.dart';
import 'logger/src/log_level.dart';
import 'logger/src/logger.dart';
import 'pretty_printer_enums.dart';

class PrettyLogger {
  late Logger _logger;
  Level _currentLevel;
  PrettyPrintLevel _currentPrinter;

  static final PrettyLogger _instance = PrettyLogger._internal();
  static PrettyLogger get instance => _instance;

  Level get level => _currentLevel;
  PrettyPrintLevel get printer => _currentPrinter;

  PrettyLogger._internal()
      : _currentLevel = Level.info,
        _currentPrinter = PrettyPrintLevel.succinctPrinter {
    _initLogger();
  }

  void _initLogger() {
    _logger = Logger(
      printer: _currentPrinter.getPrinter,
      filter: CustomLogFilter()..level = _currentLevel,
      level: _currentLevel,
    );
  }

  set level(Level level) {
    _currentLevel = level;
    _initLogger();
  }

  set printer(PrettyPrintLevel printer) {
    _currentPrinter = printer;
    _initLogger();
  }

  void finest(dynamic message) => _logger.v(message);
  void finer(dynamic message) => _logger.t(message);
  void fine(dynamic message) => _logger.d(message);
  void info(dynamic message) => _logger.i(message);
  void warning(dynamic message) => _logger.w(message);
  void severe(dynamic message) => _logger.e(message);
  void shout(dynamic message) => _logger.f(message);
}

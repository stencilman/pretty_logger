import 'package:pretty_logger/src/log_filter.dart';
import 'logger/src/log_level.dart';
import 'logger/src/logger.dart';
import 'pretty_printer_enums.dart';

class PrettyLogger {
  late Logger _logger;
  Level _currentLevel;
  PrettyPrintLevel _currentPrinter;
  bool _showLog;

  static final PrettyLogger _instance = PrettyLogger._internal();
  static PrettyLogger get instance => _instance;

  Level get level => _currentLevel;
  PrettyPrintLevel get printer => _currentPrinter;

  PrettyLogger._internal()
      : _currentLevel = Level.info,
        _currentPrinter = PrettyPrintLevel.succinctPrinter,
        _showLog = true {
    _initLogger();
  }

  void _initLogger() {
    _logger = Logger(
      printer: _currentPrinter.getPrinter,
      filter: _showLog
          ? (CustomLogFilter()..level = _currentLevel)
          : NoLogFilter(),
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

  set showLog(bool setter) {
    _showLog = setter;
    _initLogger();
  }

  void finest(dynamic message) => _showLog ? _logger.v(message) : null;
  void finer(dynamic message) => _showLog ? _logger.t(message) : null;
  void fine(dynamic message) => _showLog ? _logger.d(message) : null;
  void info(dynamic message) => _showLog ? _logger.i(message) : null;
  void warning(dynamic message) => _showLog ? _logger.w(message) : null;
  void severe(dynamic message) => _showLog ? _logger.e(message) : null;
  void shout(dynamic message) => _showLog ? _logger.f(message) : null;
}

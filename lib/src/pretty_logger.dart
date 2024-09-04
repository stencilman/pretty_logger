import 'package:logger/logger.dart';
import 'pretty_printer_enums.dart';

class PrettyLogger {
  late Logger _logger = Logger();
  Level _currentLevel;

  static final PrettyLogger _instance = PrettyLogger._internal();
  static PrettyLogger get instance => _instance;

  PrettyLogger._internal() : _currentLevel = Level.all {
    _initLogger();
  }

  void _initLogger({Level? printingLevel}) {
    _logger = Logger(
      printer: (printingLevel ?? _currentLevel).printLevel,
      filter: DevelopmentFilter()..level = _currentLevel,
      level: _currentLevel,
    );
  }

  Level get level => _currentLevel;

  set level(Level level) {
    _currentLevel = level;
    _initLogger();
  }


  void finest(dynamic message) {
    _initLogger(printingLevel: Level.trace);
    _logger.v(message);
  }

  void finer(dynamic message) {
    _initLogger(printingLevel: Level.trace);
    _logger.t(message);
  }

  void fine(dynamic message) {
    _initLogger(printingLevel: Level.debug);
    _logger.d(message);
  }

  void info(dynamic message) {
    _initLogger(printingLevel: Level.info);
    _logger.i(message);
  }

  void warning(dynamic message) {
    _initLogger(printingLevel: Level.warning);
    _logger.w(message);
  }

  void severe(dynamic message) {
    _initLogger(printingLevel: Level.error);
    _logger.e(message);
  }

  void shout(dynamic message) {
    _initLogger(printingLevel: Level.fatal);
    _logger.f(message);
  }
}

import '../log_event.dart';
import '../log_level.dart';
import '../log_printer.dart';

/// A decorator for a [LogPrinter] that allows for the composition of
/// different printers to handle different log messages. Provide it's
/// constructor with a base printer, but include named parameters for
/// any levels that have a different printer:
///
/// ```
/// HybridPrinter(PrettyPrinter(), debug: SimplePrinter());
/// ```
///
/// Will use the pretty printer for all logs except Level.debug
/// logs, which will use SimplePrinter().
class HybridPrinter extends LogPrinter {
  final Map<Level, LogPrinter> _printerMap;

  HybridPrinter(
    LogPrinter realPrinter, {
    LogPrinter? debug,
    LogPrinter? trace,
    @Deprecated('[verbose] is being deprecated in favor of [trace].')
    LogPrinter? verbose,
    LogPrinter? fatal,
    @Deprecated('[wtf] is being deprecated in favor of [fatal].')
    LogPrinter? wtf,
    LogPrinter? info,
    LogPrinter? warning,
    LogPrinter? error,
  }) : _printerMap = {
          Level.fine: debug ?? realPrinter,
          Level.finer: trace ?? verbose ?? realPrinter,
          Level.shout: fatal ?? wtf ?? realPrinter,
          Level.info: info ?? realPrinter,
          Level.warning: warning ?? realPrinter,
          Level.severe: error ?? realPrinter,
        };

  @override
  List<String> log(LogEvent event) =>
      _printerMap[event.level]?.log(event) ?? [];
}

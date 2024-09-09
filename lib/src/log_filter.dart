import '../pretty_logger.dart';

class CustomLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (event.level.value >= level!.value) {
      return true;
    }
    return false;
  }
}

import 'logger/src/log_event.dart';
import 'logger/src/log_filter.dart';

class CustomLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (event.level.value >= level!.value) {
      return true;
    }
    return false;
  }
}

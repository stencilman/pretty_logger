import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pretty_logger/src/pretty_printer_enums.dart';
import 'package:rxdart/rxdart.dart';

import 'log.dart';
import 'logger/src/log_event.dart';
import 'logger/src/log_level.dart';
import 'logger/src/logger.dart';
import 'logger/src/output_event.dart';

class LogHandler {
  static const int _maxRecordsStoredOnApp = 4000;
  static final BehaviorSubject<List<LogEvent>> _logRecords =
      BehaviorSubject<List<LogEvent>>.seeded([]);
  static Stream<List<LogEvent>> get logRecordsStream => _logRecords.stream;

  static void init() {
    log.level = Level.info;
    Logger.addLogListener(_handleLog);
    log.shout('weave, debugMode: $kDebugMode, logLevel: ${log.level}');
  }

  static void dispose() => Logger.removeLogListener((_) {});

  static void _handleLog(LogEvent record) {
    List<LogEvent> newRecords = List.from(_logRecords.value);
    final prevRecordIdx = newRecords.lastIndexWhere(
      (LogEvent l) => l.time.isBefore(record.time),
    );
    newRecords.insert(prevRecordIdx + 1, record);
    if (newRecords.length > _maxRecordsStoredOnApp) {
      newRecords.removeAt(0);
    }
    _logRecords.add(newRecords);
  }

  static String formatLogRecord(
    LogEvent record, {
    bool withDate = true,
  }) {
    final lines = log.printer.getPrinter.log(record).map(_formatLine).join('\n');
    final dateTime = DateFormat('HH:mm:ss.SS').format(record.time);
    final datePrefix =
        withDate ? DateFormat.yMd().format(record.time) : '';
    return '[${record.level.name.toUpperCase()}]  |  $datePrefix  |  $dateTime  ->  $lines';
  }

  static String _formatLine(String line) {
    String colorRegex = r'\x1B\[38;5;\d+m';
    String endColorRegex = r'\x1B\[0m';
    return line
        .replaceAll(RegExp(colorRegex), '')
        .replaceAll(RegExp(endColorRegex), '');
  }
}

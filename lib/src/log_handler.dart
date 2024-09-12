import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import 'log.dart';
import 'logger/src/log_level.dart';
import 'logger/src/logger.dart';
import 'logger/src/output_event.dart';

class LogHandler {
  static const int _maxRecordsStoredOnApp = 50000;
  static final BehaviorSubject<List<OutputEvent>> _logRecords =
      BehaviorSubject<List<OutputEvent>>.seeded([]);
  static Stream<List<OutputEvent>> get logRecordsStream => _logRecords.stream;

  static void init() {
    log.level = Level.info;
    Logger.addOutputListener(_handleLog);
    log.shout('weave, debugMode: $kDebugMode, logLevel: ${log.level}');
  }

  static void dispose() => Logger.removeOutputListener((_) {});

  static void _handleLog(OutputEvent record) {
    List<OutputEvent> newRecords = List.from(_logRecords.value);
    final prevRecordIdx = newRecords.lastIndexWhere(
      (OutputEvent l) => l.origin.time.isBefore(record.origin.time),
    );
    newRecords.insert(prevRecordIdx + 1, record);
    if (newRecords.length > _maxRecordsStoredOnApp) {
      newRecords.removeAt(0);
    }
    _logRecords.add(newRecords);
  }

  static String formatLogRecord(OutputEvent record, {bool withDate = true}) {
    final lines = record.lines.map(_formatLine).join('\n');
    final dateTime = DateFormat('HH:mm:ss.SS').format(record.origin.time);
    final datePrefix =
        withDate ? DateFormat.yMd().format(record.origin.time) : '';
    return '\n[${record.level.name.toUpperCase()}]  |  $datePrefix  |  $dateTime\n$lines';
  }

  static String _formatLine(String line) {
    String colorRegex = r'\x1B\[38;5;\d+m';
    String endColorRegex = r'\x1B\[0m';
    return line
        .replaceAll(RegExp(colorRegex), '')
        .replaceAll(RegExp(endColorRegex), '');
  }
}

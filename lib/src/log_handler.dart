import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import 'log.dart';

class LogHandler {
  static const int _maxRecordsStoredOnApp = 50000;
  static final BehaviorSubject<List<OutputEvent>> _logRecords =
      BehaviorSubject<List<OutputEvent>>.seeded([]);
  static Stream<List<OutputEvent>> get logRecordsStream => _logRecords.stream;

  static void init() {
    log.level = kDebugMode ? Level.info : Level.all;
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

  static String formatLogRecord(OutputEvent record, {bool withDate = false}) {
    final lines = record.lines.map(_formatLine).join('\n');
    final dateTime = DateFormat('HH:mm:ss.SS').format(record.origin.time);
    final datePrefix =
        withDate ? '${DateFormat.yMd().format(record.origin.time)} ' : '';
    return '\n\n$datePrefix$dateTime | ${record.level}\n$lines'
        .replaceAll('0m', '');
  }

  static String _formatLine(String line) {
    if (line.contains('package:')) {
      return _transformPackageLine(line);
    } else if (line.contains('┌')) {
      return "┌${_transformBorderLine(line).split('┌')[1]}";
    } else if (line.contains('└')) {
      return "└${_transformBorderLine(line).split('└')[1]}";
    } else if (line.contains('├')) {
      return _transformMiddleLine(line);
    } else if (line.contains('│')) {
      return "│  ${line.split('│')[1]}";
    }
    return line;
  }

  static String _transformPackageLine(String input) {
    final parts = input.split('(');
    final classFuncName = parts[0].trim().split('  ').last.trim();
    final fileName = parts[1].split('/').last.split('.')[0];
    final lineInfo = input.split(':')[2].split(')')[0];
    return '│    --->>     $classFuncName | $fileName | $lineInfo';
  }

  static String _transformBorderLine(String input) {
    final hyphens = '─' * 40;
    return "${input.split('───────')[0]}$hyphens";
  }

  static String _transformMiddleLine(String input) {
    final hyphens = '─' * 40;
    return "├$hyphens";
  }
}

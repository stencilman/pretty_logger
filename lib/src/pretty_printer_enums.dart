import 'package:logger/logger.dart';

enum PrettyPrintLevel {
  succinctPrinter,
  moderatePrinter,
  detailedPrinter,
  highlyDetailedPrinter,
}

extension PrettyPrinterEnumsExtension on PrettyPrintLevel {
  LogPrinter get printer {
    switch (this) {
      case PrettyPrintLevel.succinctPrinter:
        return SimplePrinter();

      case PrettyPrintLevel.moderatePrinter:
        return PrettyPrinter(
          stackTraceBeginIndex: 1,
          methodCount: 2,
        );
      case PrettyPrintLevel.detailedPrinter:
        return PrettyPrinter(
          stackTraceBeginIndex: 1,
          methodCount: 4,
        );
      case PrettyPrintLevel.highlyDetailedPrinter:
        return PrettyPrinter(
          stackTraceBeginIndex: 1,
          methodCount: 6,
        );
    }
  }
}

extension LevelAccordingPrettyPrintExtension on Level {
  LogPrinter get printLevel {
    if (value <= Level.debug.value) {
      return PrettyPrintLevel.succinctPrinter.printer;
    } else if (value < Level.warning.value) {
      return PrettyPrintLevel.moderatePrinter.printer;
    } else if (value == Level.error.value) {
      return PrettyPrintLevel.detailedPrinter.printer;
    } else {
      return PrettyPrintLevel.highlyDetailedPrinter.printer;
    }
  }
}

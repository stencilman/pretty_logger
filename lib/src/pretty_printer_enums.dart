import 'logger/src/log_printer.dart';
import 'logger/src/printers/pretty_printer.dart';

enum PrettyPrintLevel {
  succinctPrinter,
  moderatePrinter,
  detailedPrinter,
  highlyDetailedPrinter,
}

extension PrettyPrinterEnumsExtension on PrettyPrintLevel {
  LogPrinter get getPrinter {
    switch (this) {
      case PrettyPrintLevel.succinctPrinter:
        return PrettyPrinter(
          printEmojis: false,
          methodCount: 0,
        );

      case PrettyPrintLevel.moderatePrinter:
        return PrettyPrinter(
          stackTraceBeginIndex: 4,
          methodCount: 5,
          printEmojis: false,
        );
      case PrettyPrintLevel.detailedPrinter:
        return PrettyPrinter(
          stackTraceBeginIndex: 4,
          methodCount: 7,
          printEmojis: false,
        );
      case PrettyPrintLevel.highlyDetailedPrinter:
        return PrettyPrinter(
          stackTraceBeginIndex: 4,
          methodCount: 12,
          printEmojis: false,
        );
    }
  }

  String get getLabel {
    switch (this) {
      case PrettyPrintLevel.succinctPrinter:
        return 'Succinct';
      case PrettyPrintLevel.moderatePrinter:
        return 'Modetate (Lv 1)';
      case PrettyPrintLevel.detailedPrinter:
        return 'Detailed (Lv 3)';
      case PrettyPrintLevel.highlyDetailedPrinter:
        return 'Highly Detailed (Lv 8)';
    }
  }
}

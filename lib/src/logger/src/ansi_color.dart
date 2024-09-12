/// This class handles colorizing of terminal output.
class AnsiColor {
  /// ANSI Control Sequence Introducer, signals the terminal for new settings.
  static const ansiEsc = '\x1B[';

  /// Reset all colors and options for current SGRs to terminal defaults.
  static const ansiDefault = '${ansiEsc}0m';

  final int? fg;
  final bool color;

  const AnsiColor.none()
      : fg = null,
        color = false;

  const AnsiColor.fg(this.fg) : color = true;

  @override
  String toString() {
    if (fg != null) {
      return '${ansiEsc}38;5;${fg}m';
    } else {
      return '';
    }
  }

  String call(String msg) {
    if (color) {
      // ignore: unnecessary_brace_in_string_interps
      return '${this}$msg$ansiDefault';
    } else {
      return msg;
    }
  }

  /// Defaults the terminal's foreground color without altering the background.
  String get resetForeground => color ? '${ansiEsc}39m' : '';

  static int grey(double level) => 232 + (level.clamp(0.0, 1.0) * 23).round();
}

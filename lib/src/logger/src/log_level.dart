/// [Level]s to control logging output. Logging can be enabled to include all
/// levels above certain [Level].
enum Level {
  all(0),
  finest(999),
  finer(1000),
  fine(2000),
  info(3000),
  warning(4000),
  severe(5000),
  @Deprecated('[wtf] is being deprecated in favor of [fatal].')
  wtf(5999),
  shout(6000),
  @Deprecated('[nothing] is being deprecated in favor of [off].')
  nothing(9999),
  off(10000),
  ;

  final int value;

  const Level(this.value);
}

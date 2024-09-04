Logs that makes you wow! For both IDE Terminal and Device Console Stream.

Wrapper of [logger](https://pub.dev/packages/logger) with built-in pretty print and in the format that accomodates to the methods and structure of [logging](https://pub.dev/packages/logging).

## Getting started

1. Import the package:
```yaml
pretty_logger:
  git: git@github.com:stencilman/pretty_logger.git
```
2. Import in your project
```dart
import 'package:pretty_logger/pretty_logger.dart';
```

## Usage

1. Initialise the `LogHandler` in the beginning of `main.dart`:
```dart
void main() {
  LogHandler.init();
  ...
}
```
And dispose it in ur first screen under Material
```dart
@override
void dispose() {
  LogHandler.dispose();
  super.dispose();
}
```
2. Now just call like this:
```dart
log.info(yourAnyMessage);
```
There are many level of logs with the priority:
`finest()` < `finer()` < `fine()` < `info()` < `warning()` < `severe()` < `shout()`

`finest()` is for most useless information and `shout()` is for the most important information that requires immediate attention.

3. Set your levels like:
```dart
log.level = Level.info;
```
When the log is set at a particular level it only shows the logs of priority >= to that level. So for example, setting it to `Level.info` will hide logs of `fine()` and so on, and show only from `info()` to `shout()`

4. You can listen to the logs in any `StreamBuilder`
```dart
stream: LogHandler.logRecordsStream,
```
You can retrive the printable text from the snapshot data using:
```dart
String printableText = LogHandler.formatLogRecord(yourSnapshotData);
```

## Mapping of logging into logger package:

`Level.finest` -> `Level.verbose`

`Level.finer` -> `Level.trace`

`Level.fine` -> `Level.debug`

`Level.info` -> `Level.info`

`Level.warning` -> `Level.warning`

`Level.severe` -> `Level.error`

`Level.shout` -> `Level.fatal`

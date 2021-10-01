import 'package:logger/logger.dart';

class CommonFunctions {
  static var logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false, // Should each log print contain a timestamp
    ),
  );
  static console(msg, {type: 'debug'}) {
    if (type == 'debug') {
      logger.d(msg);
    }

    if (type == 'error') {
      logger.e(msg);
    }

    if (type == 'info') {
      logger.i(msg);
    }

    if (type == 'warning') {
      logger.w(msg);
    }

    if (type == 'verbose') {
      logger.v(msg);
    }

    if (type == 'wtf') {
      logger.wtf(msg);
    }
  }
}
import 'dart:io';

import 'package:logger/logger.dart';

import '../data/file/log_file_output.dart';

class LogManager {
  static final Logger logger = Logger(
    // output: LogFileOutput(logDirectory: Directory('logs'), logFileName: 'app'),
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static void d(String message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    logger.d(_formatMessage(message, tag), error, stackTrace);
  }

  static void i(String message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    logger.i(_formatMessage(message, tag), error, stackTrace);
  }

  static void w(String message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    logger.w(_formatMessage(message, tag), error, stackTrace);
  }

  static void e(String message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    logger.e(_formatMessage(message, tag), error, stackTrace);
  }

  static void wtf(String message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    logger.wtf(_formatMessage(message, tag), error, stackTrace);
  }

  static String _formatMessage(
    String message,
    String? tag,
  ) {
    if (tag != null && tag.isNotEmpty) {
      return '[$tag] $message';
    }
    return message;
  }
}

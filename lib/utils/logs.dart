import 'package:logger/logger.dart';

class Logs {
  static var logger = Logger(
    printer: SimplePrinter(),
  );

  static void v(dynamic message) {
    logger.v(message);
  }

  static void d(dynamic message) {
    logger.d(message);
  }

  static void i(dynamic message) {
    logger.i(message);
  }

  static void w(dynamic message) {
    logger.w(message);
  }

  static void e(dynamic message) {
    logger.e(message);
  }

  static void wtf(dynamic message) {
    logger.wtf(message);
  }
}
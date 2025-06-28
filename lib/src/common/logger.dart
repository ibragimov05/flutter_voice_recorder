import 'dart:developer';

/// Logs a severe message.
void severe(Object? message, {StackTrace? stackTrace}) => log('$message', name: 'SEVERE', stackTrace: stackTrace);

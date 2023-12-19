import 'package:flutter/material.dart';

abstract class SystemRepository {
  Future<void> saveLanguage(Locale locale);
}

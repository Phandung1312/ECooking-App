import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/account.dart';

@lazySingleton
class LocalDataSource {
  static const String _prefix = '@@app';

  final String key;
  final SharedPreferences _prefStorage;

  const LocalDataSource._(
    this.key,
    this._prefStorage,
  );

  const LocalDataSource(
      SharedPreferences prefStorage, @Named('key') String? key) : this._(key ?? 'default', prefStorage);

  String get _initializedKey => "$_prefix/$key/initialized";
  String get _languageKey => "$_prefix/$key/language";
  String get _accountKey => "$_prefix/$key/account";

  Future<int?> getInitializedVersion() async {
    return _prefStorage.getInt(_initializedKey);
  }

  Future<String?> getLanguage() async {
    return _prefStorage.getString(_languageKey);
  }

  Future<String> saveDefaultLanguage(String language) async {
    final currentLanguage = await getLanguage();

    if (currentLanguage != null) return currentLanguage;

    await _prefStorage.setString(_languageKey, language);

    return language;
  }

  Future<void> saveLanguage(String? language) async {
    if (language == null) {
      await _prefStorage.remove(_languageKey);
      return;
    }

    await _prefStorage.setString(_languageKey, language);
  }

  Future<void> clearAll() async {
    await _prefStorage.clear();
  }

  Future<void> clearUserInfo() async {
    await saveLanguage(null);
  }

  Future<void> saveAccount(Account account) async {
    await _prefStorage.setString(_accountKey, json.encode(account.toJson()));
  }
  Future<Account?> getAccount() async {
    var accountString = _prefStorage.getString(_accountKey);
    if (accountString != null) {
      return Account.fromJson(jsonDecode(accountString));
    }
    return null;
  }
  Future<void> removeAccount() async {
    await _prefStorage.remove(_accountKey);
  }
}

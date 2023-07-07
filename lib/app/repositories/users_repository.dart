import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart' show DateUtils;

import '/app/app.dart';
import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/app_store.dart';
import '/app/services/api.dart';

class UsersRepository {
  final AppStore store;

  AppDataStore get dataStore => store.dataStore;
  Api get api => store.api;

  UsersRepository(this.store);

  bool get isLoggedIn => api.isLoggedIn;

  Future<User> getUser() {
    return dataStore.usersDao.getUser();
  }

  Future<void> loadUserData() async {
    try {
      ApiUserData userData = await api.getUserData();

      await dataStore.usersDao.loadUser(userData.toDatabaseEnt());
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> login(String url, String login, String password) async {
    try {
      await api.login(url: url, login: login, password: password);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    await loadUserData();
    await dataStore.updatePref(
      PrefsCompanion(logoutAfter: Value(DateUtils.dateOnly(DateTime.now().add(const Duration(days: 1)))))
    );
  }

  Future<void> logout() async {
    try {
      await api.logout();
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }

    await dataStore.clearData();
  }

  Future<void> resetPassword(String url, String login) async {
    try {
      await api.resetPassword(url: url, login: login);
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await App.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }
}

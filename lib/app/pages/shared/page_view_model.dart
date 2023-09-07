import 'dart:async';

import 'package:drift/drift.dart' show TableUpdateQuery;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/data/database.dart';
import '/app/app.dart';
import '/app/repositories/app_store.dart';

abstract class PageViewModel<T, P> extends Cubit<T> {
  late final StreamSubscription _subscription;
  late final App app = App.instance!;
  final BuildContext context;

  PageViewModel(this.context, T state) : super(state) {
    initViewModel();
  }

  P get status;

  AppStore get store => app.store;
  AppDataStore get dataStore => app.store.dataStore;

  TableUpdateQuery get listenForTables => TableUpdateQuery.onAllTables([]);

  @mustCallSuper
  Future<void> initViewModel() async {
    _subscription = dataStore.tableUpdates(listenForTables).listen((event) async {
      await Future.delayed(Duration.zero);
      await loadData();
    });
    await loadData();
  }

  @protected
  Future<void> loadData();

  @override
  void emit(T state) {
    if (!isClosed) super.emit(state);
  }

  @override
  Future<void> close() async {
    _subscription.cancel();

    super.close();
  }
}

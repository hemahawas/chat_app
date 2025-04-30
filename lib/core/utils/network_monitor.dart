import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkMonitor {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _subscription;
  final ValueNotifier<bool> isOnline = ValueNotifier(false);
  final InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker.createInstance();

  void startMonitoring() {
    _subscription = _connectivity.onConnectivityChanged.listen((result) async {
      final hasInternet = await internetConnectionChecker.hasConnection;
      isOnline.value = hasInternet;
    });

    // Initial check
    _connectivity.checkConnectivity().then((result) async {
      final hasInternet = await internetConnectionChecker.hasConnection;
      isOnline.value = hasInternet;
    });
  }

  void stopMonitoring() {
    _subscription.cancel();
  }
}

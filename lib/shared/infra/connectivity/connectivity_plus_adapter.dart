import 'package:connectivity_plus/connectivity_plus.dart';

import '../../data/data.dart';

class ConnectivityPlusAdapter implements CheckConnectivity {
  final Connectivity connectivity;

  ConnectivityPlusAdapter({required this.connectivity});

  @override
  Future<bool> call() async {
    final isConnected = await connectivity.checkConnectivity();
    if (isConnected == ConnectivityResult.mobile ||
        isConnected == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';

import 'network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  late ConnectivityResult connectivityResult;
  NetworkInfoImpl({required this.connectivity});

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await netWorkConnectionResult;
    late bool connectedToANetwork;
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      connectedToANetwork = true;
    } else {
      connectedToANetwork = false;
    }
    return connectedToANetwork;
  }

  Future<ConnectivityResult> get netWorkConnectionResult async =>
      await connectivity.checkConnectivity();
}

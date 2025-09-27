import 'package:connectivity_plus/connectivity_plus.dart';

abstract class CheckInternetConnection {
  Future<bool> get isConnected;
}

class GetNetworkInfo implements CheckInternetConnection {
  final Connectivity _connectivity;

  GetNetworkInfo([Connectivity? connectivity])
    : _connectivity = connectivity ?? Connectivity();

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}

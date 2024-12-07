import 'package:connectivity_plus/connectivity_plus.dart';

/// Abstract class that defines network connectivity information.
///
/// Provides a method to check whether the device is currently connected to the internet.
abstract class NetworkInfo {
  /// A future that returns `true` if the device is connected to the internet, otherwise `false`.
  Future<bool> get isConnected;
}

/// Implementation of [NetworkInfo] that uses the [Connectivity] package to check network connectivity.
///
/// This class uses the `Connectivity` package to determine the current network status and implements
/// the `isConnected` getter to return whether the device is connected to the internet.
class NetworkInfoImpl implements NetworkInfo {
  /// Creates an instance of `NetworkInfoImpl` with the provided [connectivity].
  ///
  /// [connectivity] - An instance of `Connectivity` used to check network status.
  NetworkInfoImpl(this.connectivity);

  /// An instance of `Connectivity` used to check the current network connectivity status.
  final Connectivity connectivity;

  /// Checks if the device is connected to the internet.
  ///
  /// Uses the `Connectivity.checkConnectivity` method to determine the current network status and
  /// returns `true` if the device is connected to any network (WiFi, mobile data), otherwise `false`.
  @override
  Future<bool> get isConnected async {
    final connectivityResult = await connectivity.checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }
}

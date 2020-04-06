import 'package:local_auth/local_auth.dart';

class AuthController {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticate() async {
    if (await _isBiometricAvailable()) {
      await _getListOfBiometricTypes();
      return await _authenticateUser();
    }

    return false;
  }

  Future<bool> _isBiometricAvailable() async {
    try {
      bool isAvailable = await _auth.canCheckBiometrics;
      return isAvailable;
    } catch (ex) {
      print(ex);
      return false;
    }
  }

  Future _getListOfBiometricTypes() async {
    try {
      await _auth.getAvailableBiometrics();
    } catch (ex) {
      print(ex);
    }
  }

  Future<bool> _authenticateUser() async {
    try {
      bool isAuthenticated = await _auth.authenticateWithBiometrics(
        localizedReason: "Autentique-se para prosseguir",
        useErrorDialogs: true,
        stickyAuth: true,
      );

      return isAuthenticated;
    } catch (ex) {
      print(ex);
      return false;
    }
  }
}

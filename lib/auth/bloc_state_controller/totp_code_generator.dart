// Generates a Time-based One-Time Password (TOTP) string.
import 'package:otp/otp.dart';

String generateTOTP(String secret) {
  // Returns the generated TOTP code.
  return OTP.generateTOTPCodeString(
    // The shared secret key.
    secret,
    // The current time in milliseconds since epoch.
    DateTime.now().millisecondsSinceEpoch,
    // The period for which the code is valid, in seconds.
    interval: 30,
    // The hashing algorithm to use.
    algorithm: Algorithm.SHA1,
    // Specifies if it should follow Google Authenticator's implementation.
    isGoogle: true,
  );
}
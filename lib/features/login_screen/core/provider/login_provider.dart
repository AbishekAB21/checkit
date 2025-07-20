import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/features/login_screen/core/database/login_db.dart';

final logInProvider = Provider((ref) => LoginDb());

// Holds value of VerificationID to be passed between OTP and login Screens
final verificationIDProvider = StateProvider<String?>((ref) => null);

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/features/otp_verification_screen/core/database/otp_db.dart';

final otpProvider = Provider((ref) => OtpDb());

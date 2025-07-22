import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Use this widget for loading state purposes.

final authLoadingProvider = StateProvider<bool>((ref)=> false);
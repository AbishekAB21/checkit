import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';

class PhoneNumberSection extends ConsumerWidget {

  final void Function(String?) onPhoneNumberChanged;
  const PhoneNumberSection({super.key, required this.onPhoneNumberChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);

    return IntlPhoneField(
      style: Fontstyles.roboto15px(context, ref),
      keyboardType: TextInputType.number,
      initialCountryCode: "IN",
      // Textfield
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: color.iconColor),
        ),
        filled: true,
        fillColor: color.background,
      ),

      // Dropdown
      dropdownIconPosition: IconPosition.trailing,
      dropdownIcon: Icon(Icons.arrow_drop_down, color: color.iconColor),
      dropdownTextStyle: Fontstyles.roboto15px(context, ref),
      dropdownDecoration: BoxDecoration(
        border: Border.all(color: color.hintTextColor),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      
      // On changed
      onChanged: (phone) {
        
        // ignore: unnecessary_null_comparison
        if(onPhoneNumberChanged != null){

          onPhoneNumberChanged(phone.completeNumber);
        }
      },
    );
  }
}

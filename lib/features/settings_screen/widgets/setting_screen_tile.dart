import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/fontstyles/fontstyles.dart';

class SettingScreenTile extends ConsumerWidget {
  final String tilename;
  final Widget tileWidget;
  const SettingScreenTile({
    super.key,
    required this.tilename,
    required this.tileWidget,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(tilename, style: Fontstyles.roboto18px(context, ref)),
        tileWidget,
      ],
    );
  }
}

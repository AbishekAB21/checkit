import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkit/utils/theme/app_colors.dart';
import 'package:checkit/utils/fontstyles/fontstyles.dart';
import 'package:checkit/utils/constants/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:checkit/common/taransitions/custom_page_fade_transition.dart';
import 'package:checkit/features/home_screen/core/providers/home_screen_provider.dart';
import 'package:checkit/features/settings_screen/container/settings_screen_container.dart';
import 'package:checkit/features/settings_screen/core/providers/settings_screen_provider.dart';

class WelcomeTextSection extends ConsumerWidget {
  const WelcomeTextSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(userNameProvider);
    final profilePicUrl = ref.watch(profilePicUrlProvider);

    return username.when(
      data:
          (name) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${AppConstants.hi}, ${name ?? "User"}",
                style: Fontstyles.roboto25px(context, ref),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CustomFadeTransition(route: SettingsScreenContainer()),
                  );
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: appcolor.secondaryGradient2,
                  ),
                  clipBehavior: Clip.antiAlias, // Ensure corners are clipped
                  child: profilePicUrl.when(
                    data: (url) {
                      if (url != null && url.isNotEmpty) {
                        return CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, _) => Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                          errorWidget:
                              (context, _, __) => Image.asset(
                                "assets/images/profilePlaceholder.png",
                                fit: BoxFit.cover,
                              ),
                        );
                      } else {
                        return Image.asset(
                          "assets/images/profilePlaceholder.png",
                          fit: BoxFit.cover,
                        );
                      }
                    },
                    loading:
                        () => Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                    error:
                        (error, _) => Image.asset(
                          "assets/images/profilePlaceholder.png",
                          fit: BoxFit.cover,
                        ),
                  ),
                ),
              ),
            ],
          ),
      error:
          (error, stack) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppConstants.forgotYourname,
                style: Fontstyles.roboto25px(context, ref),
              ),
            ],
          ),
      loading: () => CircularProgressIndicator(),
    );
  }
}

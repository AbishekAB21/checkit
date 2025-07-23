import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:checkit/utils/theme/app_colors.dart';
import 'package:checkit/features/settings_screen/core/providers/theme_provider.dart';
import 'package:checkit/features/settings_screen/core/providers/settings_screen_provider.dart';

class ProfilePictureWidget extends ConsumerWidget {
  const ProfilePictureWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeProvider);
    final profilePicUrlAsync = ref.watch(profilePicUrlProvider);
    final picLoading = ref.watch(profilePicLoadingProvider);
    final picController = ref.read(profilePicControllerProvider);

    return GestureDetector(
      onTap: () async {
        await picController.pickAndUploadImage();
      },
      onLongPress: () {
        // Expand image
        showDialog(
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.all(15),
              child: Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.antiAlias,
                  child: _buildProfileImage(profilePicUrlAsync, color),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color.secondaryGradient1,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Stack(
          children: [
            // If image is loaded and avaialable
            _buildProfileImage(profilePicUrlAsync, color),

            // If image is loading
            if (picLoading) _buildLoadingOverlay(color),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(
    AsyncValue<String> profilePicUrlAsync,
    Appcolor color,
  ) {
    return profilePicUrlAsync.when(
      // When the URL is fetched succesfully
      data:
          (url) => ClipOval(
            child: CachedNetworkImage(
              imageUrl: url,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 500),

              // Loading indicator shown while the image is being downloaded
              placeholder:
                  (context, url) => Shimmer.fromColors(
                    baseColor: color.secondaryGradient1,
                    highlightColor: color.textfieldBackground,
                    child: Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(color: color.iconColor),
                    ),
                  ),

              //  Fallback logic for when the image download fails
              errorWidget:
                  (context, url, error) => Image.asset(
                    "assets/images/profilePlaceholder.png",
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
            ),
          ),

      // Loading indicator shown while the URL is being fetched
      loading:
          () => Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: color.secondaryGradient2,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CircularProgressIndicator(color: color.iconColor),
            ),
          ),

      // Fallback logic for when the URL fetching fails
      error:
          (error, _) => CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage("assets/images/profilePlaceholder.png"),
          ),
    );
  }

  // Loading indicator shown while the user is selecting a picture.
  Widget _buildLoadingOverlay(Appcolor color) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: color.secondaryGradient2.withValues(alpha: 0.6),
        shape: BoxShape.circle,
      ),
      child: Center(child: CircularProgressIndicator(color: color.iconColor)),
    );
  }
}

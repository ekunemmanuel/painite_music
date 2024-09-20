import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/assets/app_assets.dart';

class TopCard extends StatelessWidget {
  const TopCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: SizedBox(
          height: 140,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(AppAssets.homeTopCard),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  AppAssets.homeArtist,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/config/assets/app_assets.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.logo,
      height: 30,
    );
  }
}

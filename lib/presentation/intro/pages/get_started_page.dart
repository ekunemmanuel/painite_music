import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:panite_music/common/widgets/basic_app_button.dart';
import 'package:panite_music/core/config/assets/app_assets.dart';
import 'package:panite_music/core/config/theme/app_colors.dart';

import '../../choose_mode/pages/choose_mode_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppAssets.introBG,
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              const Spacer(),
              SvgPicture.asset(
                AppAssets.logo,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Enjoy listening to your favorite music',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Listen to your favorite music on the go. With our app, you can access millions of songs, create playlists, and enjoy personalized recommendations. Whether you are commuting, working out, or just relaxing at home, our app has got you covered. Download now and start your musical journey!',
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BasicAppButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ChooseModePage()));
                  },
                  name: 'Get Started'),
            ],
          ),
        ),
        IgnorePointer(
          ignoring: true,
          child: Container(
            color: Colors.black.withOpacity(0.15),
          ),
        )
      ],
    ));
  }
}

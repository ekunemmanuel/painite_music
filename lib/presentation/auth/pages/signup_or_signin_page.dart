import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:panite_music/common/widgets/basic_app_button.dart';
import 'package:panite_music/core/config/assets/app_assets.dart';
import 'package:panite_music/core/config/theme/app_colors.dart';
import 'package:panite_music/presentation/auth/pages/signup_page.dart';

import '../../../common/widgets/basic_app_bar.dart';
import 'signin_page.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BasicAppBar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppAssets.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppAssets.bottomPattern),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppAssets.authBG),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(height: 100),
                SvgPicture.asset(AppAssets.logo),
                const SizedBox(height: 50),
                const Text(
                  'Enjoy listening to Music',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Millions of songs. Free on Panite Music.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.grey),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BasicAppButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SignupPage()));
                        },
                        name: 'Sign Up'),
                    const SizedBox(width: 10),
                    BasicAppButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SigninPage()));
                      },
                      name: 'Sign In',
                      // color: AppColor.grey,
                      backgroundColor: WidgetStateProperty.all(
                        Colors.transparent,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:panite_music/presentation/auth/pages/signup_or_signin_page.dart';

import '../../../common/widgets/basic_app_button.dart';
import '../../../core/config/assets/app_assets.dart';
import '../bloc/theme_cubit.dart';
import '../widgets/choose_mode_button.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

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
                AppAssets.chooseModeBG,
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
                'Choose your mode',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChooseModeButton(
                    onTap: () {
                      context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                    },
                    icon: AppAssets.moon,
                    mode: 'Dark mode',
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ChooseModeButton(
                    onTap: () {
                      context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                    },
                    icon: AppAssets.sun,
                    mode: 'Light mode',
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              BasicAppButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SignupOrSigninPage()));
                  },
                  name: 'Continue'),
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

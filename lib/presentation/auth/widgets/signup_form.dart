import 'package:flutter/material.dart';
import 'package:panite_music/common/widgets/basic_app_button.dart';
import 'package:panite_music/data/models/auth/create_user_req.dart';
import 'package:panite_music/domain/usecases/auth/signup_usecase.dart';
import 'package:panite_music/presentation/home/pages/home_page.dart';
import 'package:panite_music/service_locator.dart';
import 'custom_text_field.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key, required this.onLoading});
  final Function(bool) onLoading;
  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Full Name',
            controller: _fullNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
            label: 'Full Name',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            hintText: 'Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            label: 'Email',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            hintText: 'Password',
            controller: _passwordController,
            textInputAction: TextInputAction.done,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
            label: 'Password',
          ),
          const SizedBox(height: 20),
          BasicAppButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                widget.onLoading(true);
                FocusScope.of(context).unfocus();

                // Perform sign up action
                final result = await sl<SignupUsecase>().call(
                  params: CreateUserReq(
                    fullName: _fullNameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
                result.fold(
                  (failure) {
                    widget.onLoading(false);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(failure),
                      ),
                    );
                  },
                  (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(success),
                      ),
                    );
                    widget.onLoading(false);

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const HomePage()),
                        (router) => false);
                  },
                );
              }
            },
            name: 'Create Account',
          ),
        ],
      ),
    );
  }
}

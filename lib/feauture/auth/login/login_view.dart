import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_project/feauture/auth/register/register_view.dart';
import 'package:flutter_bootcamp_project/feauture/main_view.dart';
import 'package:flutter_bootcamp_project/product/cubit/auth_cubit.dart';
import 'package:flutter_bootcamp_project/product/init/language/locale_keys.g.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/context_extension.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/string_extension.dart';
import 'package:get_it/get_it.dart';

part "login_view_mixin.dart";

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => GetIt.I<AuthCubit>(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) => _controlAuthStatus(state),
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildForm(context, state),
            );
          },
        ),
      ),
    );
  }

  Form _buildForm(BuildContext context, AuthState state) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.login_title.localize,
              style: context.textTheme.headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: context.screenHeight * 0.05),
          Text(
            LocaleKeys.login_description.localize,
            style:
                context.textTheme.headlineSmall?.copyWith(color: Colors.grey),
          ),
          SizedBox(height: context.screenHeight * 0.05),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: LocaleKeys.login_form_email_label.localize,
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.login_form_email_validator.localize;
              }
              return null;
            },
          ),
          SizedBox(height: context.screenHeight * 0.02),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: LocaleKeys.login_form_password_label.localize,
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.login_form_password_validator.localize;
              }
              return null;
            },
          ),
          SizedBox(height: context.screenHeight * 0.05),
          SizedBox(
            width: double.infinity,
            height: context.screenHeight * 0.06,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                state.status == AuthStatus.loading
                    ? null
                    : _loginButtonPressed();
              },
              child: state.status == AuthStatus.loading
                  ? const CircularProgressIndicator()
                  : Text(LocaleKeys.login_title.localize),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterView(),
                  ));
            },
            child: Text(LocaleKeys.login_link_text.localize),
          ),
        ],
      ),
    );
  }
}

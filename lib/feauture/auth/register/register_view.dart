import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_project/feauture/main_view.dart';
import 'package:flutter_bootcamp_project/product/cubit/auth_cubit.dart';
import 'package:flutter_bootcamp_project/product/init/language/locale_keys.g.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/context_extension.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/string_extension.dart';
import 'package:get_it/get_it.dart';

part 'register_view_mixin.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with RegisterViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => GetIt.I<AuthCubit>(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      state.errorMessage ?? LocaleKeys.register_error.localize),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state.status == AuthStatus.authenticated) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => MainView(),
              ));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildform(context, state),
            );
          },
        ),
      ),
    );
  }

  Form _buildform(BuildContext context, AuthState state) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.register_title.localize,
              style: context.textTheme.headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: context.screenHeight * 0.05),
          Text(
            LocaleKeys.register_description.localize,
            style:
                context.textTheme.headlineSmall?.copyWith(color: Colors.grey),
          ),
          SizedBox(height: context.screenHeight * 0.05),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: LocaleKeys.register_form_username_label.localize,
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.register_form_username_validator.localize;
              }
              return null;
            },
          ),
          SizedBox(height: context.screenHeight * 0.02),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: LocaleKeys.register_form_email_label.localize,
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.register_form_email_validator.localize;
              }
              return null;
            },
          ),
          SizedBox(height: context.screenHeight * 0.02),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: LocaleKeys.register_form_password_label.localize,
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys
                    .register_form_password_validator_empty.localize;
              }
              if (value.length < 6) {
                return LocaleKeys
                    .register_form_password_validator_length.localize;
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
              onPressed: state.status == AuthStatus.loading
                  ? null
                  : _registerButtonPressed,
              child: state.status == AuthStatus.loading
                  ? const CircularProgressIndicator()
                  : Text(LocaleKeys.register_title.localize),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(LocaleKeys.register_link_text.localize),
          ),
        ],
      ),
    );
  }
}

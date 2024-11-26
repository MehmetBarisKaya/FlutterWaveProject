part of 'register_view.dart';

mixin RegisterViewMixin on State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  _registerButtonPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      GetIt.I<AuthCubit>().signUp(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
      );
    }
  }
}

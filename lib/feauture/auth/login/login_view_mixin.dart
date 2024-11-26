part of 'login_view.dart';

mixin LoginViewMixin on State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _controlAuthStatus(AuthState state) {
    if (state.status == AuthStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(state.errorMessage ?? LocaleKeys.general_error.localize),
          backgroundColor: Colors.red,
        ),
      );
    } else if (state.status == AuthStatus.authenticated) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainView(),
      ));
    }
  }

  _loginButtonPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      GetIt.I<AuthCubit>().signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_check/home_screen.dart';
import 'package:fresh_check/presentation/bloc/auth/auth_bloc.dart';
import 'package:fresh_check/presentation/bloc/auth/auth_event.dart';
import 'package:fresh_check/presentation/bloc/auth/auth_state.dart';

class LoginScreen extends StatelessWidget {
  final bool isLogin;

  const LoginScreen({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authentication')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              // Showing the loading indicator while the user is signing in
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AuthInitial || state is AuthFailure) {
              return LoginForm(isLogin: isLogin);
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  bool isLogin;

  LoginForm({super.key, required this.isLogin});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                if (!emailRegExp.hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
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
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => {
                if (_formKey.currentState!.validate())
                  {
                    if (widget.isLogin)
                      {
                        context.read<AuthBloc>().add(
                              SignInEvent(
                                _emailController.text,
                                _passwordController.text,
                              ),
                            )
                      }
                    else
                      {
                        context.read<AuthBloc>().add(
                              SignUpEvent(
                                _emailController.text,
                                _passwordController.text,
                              ),
                            )
                      }
                  }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6F8F72),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: Text(widget.isLogin ? 'Log In' : 'Sign Up'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.isLogin = !widget.isLogin;
                });
              },
              child: Text(
                widget.isLogin ? 'Switch to Sign Up' : 'Switch to Log In',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF77AD78),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

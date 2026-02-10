import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghost_counter/features/auth/presentation/bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMsg)));
          }
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // অ্যাপের লোগো বা টাইটেল
                  const Text(
                    "Ghost Counter",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Sign in to track your counts securely",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 50),

                  // লোডিং এর সময় স্পিনার দেখাবে, নাহলে বাটন
                  if (state is AuthLoading)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.grey),
                      ),
                      onPressed: () {
                        // গুগল সাইন-ইন ইভেন্ট ট্রিগার করা
                        context.read<AuthBloc>().add(GoogleSignInEvent());
                      },
                      icon: const Icon(Icons.login, color: Colors.red),
                      label: const Text("Sign in with Google"),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

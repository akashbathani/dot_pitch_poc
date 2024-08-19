import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/auth_bloc/auth_bloc.dart';
import '../../controllers/auth_bloc/auth_event.dart';
import '../../controllers/auth_bloc/auth_state.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfeild.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color.fromRGBO(91, 193, 239, 1)),
            padding: const EdgeInsets.all(8.0),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Registration',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                labelText: 'Email Address',
                hintText: 'abc@gmail.com',
                inputType: InputType.email,
                controller: emailController,
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                labelText: 'Password',
                hintText: '#123ABC',
                inputType: InputType.password,
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                labelText: 'Confirm Password',
                hintText: '#123ABC',
                obscureText: true,
                inputType: InputType.password,
                controller: confirmPasswordController,
              ),
              const SizedBox(height: 32.0),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthRegisterSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Registration successful")),
                    );
                    context.pushReplacementNamed('/home');
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          BlocProvider.of<AuthBloc>(context).add(
                            RegisterEvent(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Passwords do not match")),
                          );
                        }
                      }
                    },
                    text: "Register",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

enum InputType { phone, name, email, password, address }

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final InputType inputType;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    required this.inputType,
  }) : super(key: key);

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return '$labelText cannot be empty';
    }
    switch (inputType) {
      case InputType.phone:
        return _validatePhone(value);
      case InputType.name:
        return _validateName(value);
      case InputType.email:
        return _validateEmail(value);
      case InputType.password:
        return _validatePassword(value);
      case InputType.address:
        return _validateAddress(value);
      default:
        return null;
    }
  }

  String? _validatePhone(String value) {
    final regex = RegExp(r'^[0-9]{10}$');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? _validateName(String value) {
    if (value.length < 2) {
      return 'Enter a valid name';
    }
    return null;
  }

  String? _validateEmail(String value) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateAddress(String value) {
    if (value.length < 10) {
      return 'Address must be at least 10 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        TextFormField(
          maxLines: inputType == InputType.address ? 3 : 1,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            labelStyle: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
            ),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontFamily: 'Poppins',
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          validator: _validateInput,
        ),
      ],
    );
  }
}

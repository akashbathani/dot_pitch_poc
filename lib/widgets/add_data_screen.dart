import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../controllers/add_data_bloc/add_data_bloc.dart';
import '../controllers/add_data_bloc/add_data_event.dart';
import '../controllers/add_data_bloc/add_data_state.dart';
import 'custom_button.dart';
import 'custom_textfeild.dart';

class AddDataPage extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(91, 193, 239, 1),
        leading: IconButton(
          icon: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            padding: const EdgeInsets.all(8.0),
            child: const Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(91, 193, 239, 1),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Add Data',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocListener<AddDataBloc, AddDataState>(
        listener: (context, state) {
          if (state is AddDataSuccess) {
            context.pushNamed("/home");
          } else if (state is AddDataFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: _firstNameController,
                    labelText: 'First Name',
                    hintText: 'DotPitch',
                    inputType: InputType.name,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    controller: _lastNameController,
                    labelText: 'Last Name',
                    hintText: 'Technologies',
                    inputType: InputType.name,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'dot@gmail.com',
                    inputType: InputType.email,
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _phoneNumberController,
                    labelText: 'Mobile Number',
                    hintText: '1234567890',
                    inputType: InputType.phone,

                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _addressController,
                    labelText: "Address",
                    hintText: 'xya corner',
                    inputType: InputType.address,
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<AddDataBloc, AddDataState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: state is AddDataLoading ? 'Adding...' : 'Add Data',
                        onPressed: () {
                          if (state is! AddDataLoading) {
                            if(_formKey.currentState!.validate()) {
                              context.read<AddDataBloc>().add(
                                  AddDataButtonPressed(
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                    email: _emailController.text,
                                    phoneNumber: _phoneNumberController.text,
                                    address: _addressController.text,
                                  ),
                                );
                            }
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

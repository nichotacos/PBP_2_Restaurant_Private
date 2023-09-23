import 'package:flutter/material.dart';
import 'package:pbp_2_restaurant/View/signUp.dart';
import 'package:pbp_2_restaurant/View/form_component.dart';

class signUpView extends statefulWidget {
  const signUpView({super.key});

  @override
  State<signUpView> createState() => _signUpViewState();
}

class _signUpViewState extends State<signUpView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController date = TextEditingController();
}

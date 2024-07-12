import 'package:flutter/material.dart';

class BaseTextField extends StatefulWidget {
  const BaseTextField({
    super.key,
    this.height,
  });

  final double? height;

  @override
  State<BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
          ),
        ),
        _ErrorText(),
      ],
    );
  }
}

class _ErrorText extends StatelessWidget {
  const _ErrorText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

import 'package:danter/widgets/write.dart';

import 'package:flutter/material.dart';

class WriteScreen extends StatelessWidget {
  WriteScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('New Danter'), elevation: 0.5,),
      body:  Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned.fill(
          top: 0,
          right: 0,
          left: 0,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FildWrite(controller: _controller),
              ],
            ),
          ),
        ),
        const Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SendPostWrite(),
        )
      ],
    ),
    );
  }
}

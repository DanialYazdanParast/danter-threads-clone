import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/di/di.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/write/bloc/write_bloc.dart';
import 'package:danter/widgets/write.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteScreen extends StatelessWidget {
  const WriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return BlocProvider(
      create: (context) => WriteBloc(locator.get()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('New Danter'),
          elevation: 0.5,
        ),
        body: Stack(
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                color: Colors.white,
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Anyone can reply',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .apply(fontSizeFactor: 0.9),
                    ),
                    BlocConsumer<WriteBloc, WriteState>(
                      listener: (context, state) {
                        if (state is WriteSuccesState) {
                          BlocProvider.of<ProfileBloc>(context).add(
                              ProfileRefreshEvent(
                                  user: AuthRepository.readid()));
                          _controller.text = '';
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                            margin: const EdgeInsets.only(bottom: 45,left: 30,right: 30),
                              
                            //  width: 280.0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(15)
                              ),
                              content: const Center(child: Padding(
                                padding: EdgeInsets.all(14),
                                child: Text('با موفقیت ثبت شد'),
                              )),
                            ),
                          );
                        } else if (state is WriteErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Center(child: Text(state.exception.message)),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            if (_controller.text.isNotEmpty) {
                              BlocProvider.of<WriteBloc>(context).add(
                                  WriteSendPostEvent(
                                      user: AuthRepository.readid(),
                                      text: _controller.text));
                            }
                          },
                          child: state is WriteLodingState
                              ? const CupertinoActivityIndicator()
                              : const Text(
                                  'Post',
                                  style: TextStyle(
                                      fontFamily: 'Shabnam',
                                      fontSize: 18,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600),
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

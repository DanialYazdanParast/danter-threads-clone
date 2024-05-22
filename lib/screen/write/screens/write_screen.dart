import 'package:danter/core/constants/variable_onstants.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/write/bloc/write_bloc.dart';
import 'package:danter/core/widgets/snackbart.dart';
import 'package:danter/core/widgets/write.dart';
import 'package:danter/screen/write/widgets/send_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return BlocProvider(
      create: (context) => WriteBloc(locator.get()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('New Danter'),
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(2.0), child: Divider()),
        ),
        body: BlocConsumer<WriteBloc, WriteState>(
          listener: (context, state) {
            if (state is WriteSuccesState) {
              BlocProvider.of<ProfileBloc>(context)
                  .add(ProfileRefreshEvent(user: AuthRepository.readid()));
              VariableConstants.selectedImage = [];
              controller.text = '';

              ScaffoldMessenger.of(context).showSnackBar(
                snackBarApp(themeData, 'با موفقیت ثبت شد', 45, context),
              );
            } else if (state is WriteErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  snackBarApp(themeData, state.exception.message, 45, context));
            }
          },
          builder: (context, state) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned.fill(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FildWrite(
                          controller: controller,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SendPost(controller: controller, state: state),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

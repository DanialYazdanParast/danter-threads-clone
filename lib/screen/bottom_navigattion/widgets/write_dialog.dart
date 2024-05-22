import 'package:danter/core/constants/variable_onstants.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/core/widgets/snackbart.dart';
import 'package:danter/core/widgets/write.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:danter/screen/write/bloc/write_bloc.dart';
import 'package:danter/screen/write/widgets/send_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteDialog extends StatefulWidget {
  const WriteDialog({
    super.key,
    required this.onTab,
  });

  final Function(int index) onTab;

  @override
  State<WriteDialog> createState() => _WriteDialogState();
}

class _WriteDialogState extends State<WriteDialog> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Dialog(
        elevation: 0,
        backgroundColor: themeData.scaffoldBackgroundColor,
        child: Container(
          decoration: BoxDecoration(
              color: themeData.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15)),
          width: 600,
          height: 300,
          child: BlocProvider(
            create: (context) => WriteBloc(locator.get()),
            child: BlocConsumer<WriteBloc, WriteState>(
              listener: (context, state) {
                if (state is WriteSuccesState) {
                  BlocProvider.of<ProfileBloc>(context)
                      .add(ProfileRefreshEvent(user: AuthRepository.readid()));
                  VariableConstants.selectedImage = [];
                  controller.text = '';

                  ScaffoldMessenger.of(context).showSnackBar(
                    snackBarApp(themeData, 'با موفقیت ثبت شد', 45, context),
                  );

                  Navigator.pop(context);
                  widget.onTab(profileindex);
                } else if (state is WriteErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBarApp(
                      themeData, state.exception.message, 45, context));
                }
              },
              builder: (context, state) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned.fill(
                      top: 15,
                      right: 0,
                      left: 0,
                      bottom: 15,
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
        ));
  }
}

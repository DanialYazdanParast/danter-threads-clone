import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/write/bloc/write_bloc.dart';
import 'package:danter/core/widgets/snackbart.dart';
import 'package:danter/core/widgets/write.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteScreen extends StatelessWidget {
  const WriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
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
              selectedImage = [];
              controller.text = '';

              ScaffoldMessenger.of(context).showSnackBar(
                snackBarApp(themeData, 'با موفقیت ثبت شد', 45),
              );
            } else if (state is WriteErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  snackBarApp(themeData, state.exception.message, 45));
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
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    color: themeData.scaffoldBackgroundColor,
                    height: 45,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Anyone can reply',
                              style: Theme.of(context).textTheme.labelSmall),
                          GestureDetector(
                            onTap: () {
                              if (controller.text.isNotEmpty ||
                                  selectedImage!.isNotEmpty) {
                                BlocProvider.of<WriteBloc>(context).add(
                                    WriteSendPostEvent(
                                        user: AuthRepository.readid(),
                                        text: controller.text,
                                        image: selectedImage!));
                              }
                            },
                            child: Container(
                              height: 30,
                              width: 55,
                              // padding: EdgeInsets.only(
                              //     left: 10, right: 10, top: 4, bottom: 4),
                              decoration: BoxDecoration(
                                  color: themeData.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(20)),
                              child: state is WriteLodingState
                                  ? Center(
                                      child: SizedBox(
                                        height: 23,
                                        width: 23,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color:
                                                themeData.colorScheme.secondary,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'Post',
                                        style: themeData.textTheme.titleMedium!
                                            .copyWith(
                                                fontSize: 14,
                                                color: themeData
                                                    .scaffoldBackgroundColor),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

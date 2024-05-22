import 'package:flutter/material.dart';

class BottomSheetCustom extends StatelessWidget {
  const BottomSheetCustom({
    super.key,
    required this.onTap,
  });

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 4,
          width: 32,
          decoration: BoxDecoration(
              color: themeData.colorScheme.secondary,
              borderRadius: BorderRadius.circular(30)),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 50, bottom: 24, left: 20, right: 20),
          child: TextButton(
            // borderRadius: BorderRadius.circular(20),
            // mouseCursor: MaterialStateMouseCursor.clickable,

            style: TextButton.styleFrom(
              minimumSize: const Size(40, 55),
              backgroundColor: themeData.colorScheme.onBackground,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              //  CircleBorder(),
              padding: const EdgeInsets.all(16),
            ),
            onPressed: onTap,
            child: Container(
              // margin: const EdgeInsets.only(left: 20, right: 20),
              // height: 50,
              // padding: const EdgeInsets.symmetric(horizontal: 15),
              // decoration: BoxDecoration(
              //     color: themeData.colorScheme.onBackground,
              //     borderRadius: BorderRadius.circular(20)),

              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                      child: Text(
                    'Delete',
                    style: TextStyle(
                        //        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 18),
                  )),
                  Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

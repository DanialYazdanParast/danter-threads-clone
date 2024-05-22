import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';

class BottomNavigationItem extends StatelessWidget {
  final String iconFileName;
  final String activeiconFileName;
  final String titel;
  final Function() onTap;
  final bool isActive;

  const BottomNavigationItem({
    super.key,
    required this.iconFileName,
    required this.activeiconFileName,
    required this.titel,
    required this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SizedBox(
      width: RootScreen.isDesktop(context) ? 170 : 70,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: TextButton(
          style: TextButton.styleFrom(
            //maximumSize: Size.fromWidth(150),

            minimumSize: const Size(40, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              !isActive
                  ? SizedBox(
                      height: 32,
                      width: 32,
                      child: Image.asset('assets/images/$iconFileName',
                          color: themeData.colorScheme.secondary),
                    )
                  : SizedBox(
                      height: 32,
                      width: 32,
                      child: Image.asset('assets/images/$activeiconFileName',
                          color: themeData.colorScheme.onPrimary),
                    ),
              Visibility(
                visible: RootScreen.isDesktop(context) ? true : false,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        titel,
                        style: isActive
                            ? themeData.textTheme.titleMedium!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              )
                            : themeData.textTheme.titleLarge!.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w100),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

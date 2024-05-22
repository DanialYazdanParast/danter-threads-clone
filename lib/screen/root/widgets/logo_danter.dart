import 'package:danter/core/widgets/logo.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoDanter extends StatelessWidget {
  const LogoDanter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 30, bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Logo(size: 36),
          Visibility(
            visible: RootScreen.isDesktop(context) ? true : false,
            child: Row(
              children: [
                const SizedBox(
                  width: 2,
                ),
                Text(
                  'Danter',
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.w100, fontSize: 20),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ButtonMessage extends StatelessWidget {
  const ButtonMessage({
    super.key,
    required this.name,
    required this.onTabButtonPrpfile,
  });

  final String name;
  final GestureTapCallback onTabButtonPrpfile;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
      height: 34,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: onTabButtonPrpfile,
        child: Text(name,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                //  color: Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.w400)),
      ),
    ));
  }
}

import 'package:danter/screen/edit_profile/screens/edit_profile.dart';

import 'package:flutter/material.dart';

class RowButtonProfile extends StatelessWidget {
  const RowButtonProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonPrpfile(
          name: 'Edit profile',
          onTabButtonPrpfile: () {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => const EditProfileScreen(),
            ));
          },
        ),
        const SizedBox(
          width: 20,
        ),
        ButtonPrpfile(
          name: 'Share profile',
          onTabButtonPrpfile: () {},
        ),
      ],
    );
  }
}

class ButtonPrpfile extends StatelessWidget {
  const ButtonPrpfile({
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
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
            onPressed: onTabButtonPrpfile,
            child: Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w400),
            )),
      ),
    );
  }
}

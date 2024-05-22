import 'package:danter/data/model/follow.dart';
import 'package:danter/screen/profile/widgets/bio_profile.dart';
import 'package:danter/screen/profile/widgets/image_and_total_followers.dart';
import 'package:danter/screen/profile/widgets/image_profile.dart';
import 'package:danter/screen/profile/widgets/name_profile.dart';
import 'package:danter/screen/profile/widgets/row_button_profile.dart';
import 'package:danter/screen/profile/widgets/user_name_profile.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final List<Followers> userFollowers;
  const Header({
    super.key,
    required this.userFollowers,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    NameProfile(),
                    //   const SizedBox(height: 10),
                    const UserNameProfile(),
                  ],
                ),
              ),
              ImageProfile()
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BioProfile(),
              if (RootScreen.isMobile(context) && userFollowers.isNotEmpty)
                ImageAndTotalFollowers(
                  userFollowers: userFollowers[0].user,
                ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const RowButtonProfile(),
        ],
      ),
    );
  }
}

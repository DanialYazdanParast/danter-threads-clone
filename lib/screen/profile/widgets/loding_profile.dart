import 'package:danter/core/widgets/loding.dart';
import 'package:danter/core/widgets/tabbar_view_delegate.dart';

import 'package:danter/screen/profile/widgets/bio_profile.dart';
import 'package:danter/screen/profile/widgets/image_profile.dart';
import 'package:danter/screen/profile/widgets/name_profile.dart';
import 'package:danter/screen/profile/widgets/row_button_profile.dart';
import 'package:danter/screen/profile/widgets/user_name_profile.dart';

import 'package:flutter/material.dart';

class LodingProfile extends StatelessWidget {
  const LodingProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
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
                                  // const SizedBox(height: 5),
                                  UserNameProfile(),
                                ],
                              ),
                            ),
                            ImageProfile()
                          ],
                        ),
                        BioProfile(),
                        const RowButtonProfile(),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: TabBarViewDelegate(
                    TabBar(
                      indicatorPadding:
                          const EdgeInsets.only(left: 20, right: 20),
                      indicatorWeight: 1,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: themeData.colorScheme.onPrimary,
                      labelColor: themeData.colorScheme.onPrimary,
                      unselectedLabelColor: themeData.colorScheme.secondary,
                      labelStyle: themeData.textTheme.titleLarge!
                          .copyWith(fontWeight: FontWeight.w700),
                      tabs: const [
                        Tab(icon: Text('Danter')),
                        Tab(icon: Text('Replies')),
                      ],
                    ),
                  ),
                  pinned: true,
                  floating: false,
                ),
              ];
            },
            body: TabBarView(children: [
              Container(),
              Container(),
            ]),
          ),
        ),
        const Positioned(top: 94, child: LodingCustom())
      ],
    );
  }
}

import 'package:danter/screen/home/widgets/appbar_home.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';

class HomeLoding extends StatelessWidget {
  const HomeLoding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: CustomScrollView(
              slivers: [
                SliverVisibility(
                    visible: RootScreen.isMobile(context),
                    sliver: const AppBarHome()),
                SliverVisibility(
                  visible: !RootScreen.isMobile(context),
                  sliver:
                      const SliverPadding(padding: EdgeInsets.only(top: 30)),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: 1,
                        ),
                        SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              color: themeData.colorScheme.secondary,
                            )),
                        Container(
                          height: 200,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

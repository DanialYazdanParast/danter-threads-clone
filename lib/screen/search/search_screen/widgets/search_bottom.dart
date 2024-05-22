import 'package:danter/screen/root/screens/root.dart';
import 'package:danter/screen/search/search_user/screens/search_user_screen.dart';
import 'package:flutter/material.dart';

class SearchBottom extends StatelessWidget {
  const SearchBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: GestureDetector(
        onTap: () {
          if (RootScreen.isMobile(context)) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const SearchUserScreen();
              },
            ));
          } else {
            RootScreen.scaffoldKey.currentState?.openDrawer();
          }
        },
        child: Container(
          height: 40,
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(10)),
          child: Row(children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Image.asset('assets/images/search.png',
                  color: Theme.of(context).colorScheme.secondary),
            ),
            const SizedBox(width: 12),
            Text(
              'Search',
              style:
                  Theme.of(context).textTheme.titleSmall!.copyWith(height: 1.6),
            )
          ]),
        ),
      ),
    );
  }
}

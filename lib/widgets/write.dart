import 'package:danter/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendPostWrite extends StatelessWidget {
  const SendPostWrite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      color: Colors.white,
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Anyone can reply',
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .apply(fontSizeFactor: 0.9),
          ),
          const Text(
            'Post',
            style: TextStyle(
                fontFamily: 'Shabnam',
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class FildWrite extends StatefulWidget {
  const FildWrite({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  State<FildWrite> createState() => _FildWriteState();
}

class _FildWriteState extends State<FildWrite> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: SizedBox(
                    width: 47,
                    height: 47,
                    child: Image.asset(
                      'assets/images/me.jpg',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daniel',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextField(
                          controller: widget._controller,
                          onChanged: (value) {
                            setState(() {
                              widget._controller;
                            });
                          },
                          minLines: 1,
                          maxLines: 50,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            isCollapsed: true,
                            // floatingLabelBehavior:
                            //     FloatingLabelBehavior.always,
                            alignLabelWithHint: false,
                            label: Text(
                              'Start a danter',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const Icon(Icons.add_a_photo_outlined),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          (widget._controller.text.isNotEmpty)
              ? const Icon(
                  CupertinoIcons.multiply,
                  color: LightThemeColors.secondaryTextColor,
                )
              : Container(),
        ],
      ),
    );
  }
}

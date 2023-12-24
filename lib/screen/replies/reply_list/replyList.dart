// import 'package:danter/data/model/post.dart';
// import 'package:danter/data/repository/auth_repository.dart';
// import 'package:danter/screen/image/image_screen.dart';
// import 'package:danter/screen/profile/bloc/profile_bloc.dart';
// import 'package:danter/screen/profile/profile_screen.dart';
// import 'package:danter/screen/profile_user/profile_user.dart';
// import 'package:danter/screen/replies/replies_screen.dart';

// import 'package:danter/screen/replies/reply_list/bloc/reply_list_bloc.dart';
// import 'package:danter/screen/replies/write_reply/write_reply.dart';

// import 'package:danter/theme.dart';
// import 'package:danter/widgets/Row_Image_Name_Text.dart';
// import 'package:danter/widgets/image.dart';

// import 'package:danter/widgets/postlist.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../di/di.dart';

// class ReplayList extends StatelessWidget {
//   final PostEntity postEntity;
//   const ReplayList({
//     super.key,
//     required this.postEntity,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ReplyListBloc(locator.get())
//         ..add(
//           ReplyListStartedEvent(
//               postId: postEntity.id, user: AuthRepository.readid()),
//         ),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
//             builder: (context) => RepliesScreen(
//               postEntity: postEntity,
//             ),
//           ));
//         },
//         child: BlocBuilder<ReplyListBloc, ReplyListState>(
//           builder: (context, state) {
//             if (state is ReplyListSuccesState) {
//               return Container(
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.white,
//                 child: Column(
//                   children: [
//                     ImageAndNameAndText(
//                         onTabmore: () {},
//                         postEntity: postEntity,
//                         onTabNameUser: () {
//                           if (postEntity.user.id == AuthRepository.readid()) {
//                             Navigator.of(context, rootNavigator: true).push(
//                               MaterialPageRoute(
//                                 builder: (context) {
//                                   return BlocProvider(
//                                     create: (context) =>
//                                         ProfileBloc(locator.get()),
//                                     child: ProfileScreen(profileBloc: ProfileBloc(locator.get())),
//                                   );
//                                 },
//                               ),
//                             );
//                           } else {
//                             Navigator.of(context, rootNavigator: true).push(
//                               MaterialPageRoute(
//                                 builder: (context) {
//                                   return ProfileUser(
//                                     user: postEntity.user,
//                                   );
//                                 },
//                               ),
//                             );
//                           }
//                         }),

//                     postEntity.image.isNotEmpty && postEntity.image.length < 2
//                         ? Padding(
//                             padding: const EdgeInsets.only(
//                                 right: 10, left: 65, bottom: 10),
//                             child: GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context, rootNavigator: true)
//                                     .push(MaterialPageRoute(
//                                   builder: (context) => ImageScreen(
//                                     image:
//                                         'https://dan.chbk.run/api/files/6291brssbcd64k6/${postEntity.id}/${postEntity.image[0]}',
//                                   ),
//                                 ));
//                               },
//                               child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(12),
//                                   child: SizedBox(
//                                     child: ImageLodingService(
//                                       imageUrl:
//                                           'https://dan.chbk.run/api/files/6291brssbcd64k6/${postEntity.id}/${postEntity.image[0]}',
//                                     ),
//                                   )),
//                             ),
//                           )
//                         : postEntity.image.length > 1
//                             ? SizedBox(
//                                 height: 260,
//                                 child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: postEntity.image.length,
//                                   itemBuilder: (context, index) {
//                                     return Padding(
//                                         padding: EdgeInsets.only(
//                                             bottom: 10,
//                                             left: (index == 0) ? 65 : 10,
//                                             right: (index ==
//                                                     postEntity.image.length - 1)
//                                                 ? 10
//                                                 : 0),
//                                         child: ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(12),
//                                           child: SizedBox(
//                                             width: 200,
//                                             child: GestureDetector(
//                                               onTap: () {
//                                                 Navigator.of(context,
//                                                         rootNavigator: true)
//                                                     .push(MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       ImageScreen(
//                                                     image:
//                                                         'https://dan.chbk.run/api/files/6291brssbcd64k6/${postEntity.id}/${postEntity.image[index]}',
//                                                   ),
//                                                 ));
//                                               },
//                                               child: ImageLodingService(
//                                                 imageUrl:
//                                                     'https://dan.chbk.run/api/files/6291brssbcd64k6/${postEntity.id}/${postEntity.image[index]}',
//                                               ),
//                                             ),
//                                           ),
//                                         ));
//                                   },
//                                 ),
//                               )
//                             : Container(),

//                     Padding(
//                       padding: const EdgeInsets.only(left: 65),
//                       child: Row(
//                         children: [
//                           GestureDetector(
//                             onTap: () async {
//                               if (state.trueLikeUser == 0) {
//                                 await state.trueLikeUser++;

//                                 BlocProvider.of<ReplyListBloc>(context).add(
//                                   AddLikeReplyListEvent(
//                                     postId: postEntity.id,
//                                     user: AuthRepository.readid(),
//                                   ),
//                                 );
//                               } else {
//                                 await state.trueLikeUser--;
//                                 BlocProvider.of<ReplyListBloc>(context).add(
//                                   RemoveLikeReplyListEvent(
//                                     postId: postEntity.id,
//                                     user: AuthRepository.readid(),
//                                     likeId: state.likeid[0].id,
//                                   ),
//                                 );
//                               }
//                             },
//                             child: Container(
//                               child: state.trueLikeUser > 0
//                                   ? const Icon(CupertinoIcons.heart_fill,
//                                       color: Colors.red, size: 24)
//                                   : const Icon(
//                                       CupertinoIcons.heart,
//                                       size: 24,
//                                     ),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 18,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.of(context, rootNavigator: true)
//                                   .push(MaterialPageRoute(
//                                 builder: (context) =>
//                                     WriteReply(postEntity: postEntity),
//                               ));
//                             },
//                             child: SizedBox(
//                               height: 22,
//                               width: 22,
//                               child: Image.asset(
//                                 'assets/images/comments.png',
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.only(left: 67, top: 10),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
// //-----------------------TextReplyAndLike----------------------//

//                           Text(state.totareplise.toString(),
//                               style: Theme.of(context).textTheme.subtitle1),
//                           const SizedBox(width: 6),
//                           Text(state.totareplise <= 1 ? 'reply' : 'replies',
//                               style: Theme.of(context).textTheme.subtitle1),
//                           const SizedBox(width: 18),
//                           Text(state.totallike.toString(),
//                               style: Theme.of(context).textTheme.subtitle1),
//                           const SizedBox(width: 6),
//                           Text(state.totallike <= 1 ? 'Like' : 'Likes',
//                               style: Theme.of(context).textTheme.subtitle1),
//                         ],
//                       ),
//                     ),
// //-----------------------TextReplyAndLike----------------------//
//                     const Divider(height: 20),
//                   ],
//                 ),
//               );
//             } else if (state is ReplyListInitial) {
//               return InitState(postEntity: postEntity);
//             } else if (state is ReplyListErrorState) {
//               return Text(
//                 'error',
//                 style: Theme.of(context).textTheme.subtitle1,
//               );
//             } else {
//               throw Exception('state is not supported ');
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

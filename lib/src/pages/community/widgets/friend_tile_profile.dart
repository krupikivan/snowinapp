// import 'package:flutter/material.dart';

// import 'package:auto_size_text/auto_size_text.dart';

// import 'package:snowin/src/models/user.dart';

// class FriendTileProfile extends StatefulWidget {
//   final User friend;
//   final AfterSendCallback afterSend;

//   FriendTileProfile({ Key key, this.friend, this.afterSend}) : super(key: key);

//   @override
//   FriendTileProfileState createState() => new FriendTileProfileState(friend);
// }

// class FriendTileProfileState extends State<FriendTileProfile> {
//   User friend;

//   FriendTileProfileState(this.friend);

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose(){
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return InkWell(
//       child: Container(
//           width: size.width,
//           margin: EdgeInsets.symmetric(vertical:5,),
//           child: Column(
//             children: [
//               Container(
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(0.0),
//                       child: IconButton(
//                         icon: Icon(Icons.message, size: 15.0,),
//                         onPressed: () {
//                         },
//                       ),
//                     ),
//                     _avatar(friend.image.toString(), size),
//                     SizedBox(width: 10,),
//                     Container(
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                               AutoSizeText(friend.username.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Color.fromRGBO(159, 159, 159, 1)),),
//                               AutoSizeText(friend.nivel.toString(), style: TextStyle(fontSize: 13),),
//                           ],
//                       ),
//                     ),
//                     Expanded(child: Container(), flex: 1),
//                     Padding(
//                       padding: EdgeInsets.all(0.0),
//                       child: IconButton(
//                         icon: Icon(Icons.message, size: 15.0,),
//                         onPressed: () {
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 8,),
//               Divider(height: 1.0, color: Colors.grey,),
//             ],
//           ),
//       ),
//       onTap: () {
//       },
//     );
//   }

//   Widget _avatar(String image, Size size) {
//     return Container(
//       width: 0.15*size.width,
//       height: 0.15*size.width,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         image: DecorationImage(
//           image: NetworkImage(image),
//           fit: BoxFit.cover
//         ),
//       ),
//     );
//   }

// }

// typedef AfterSendCallback = void Function();

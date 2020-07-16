import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/pages/community/provider/export.dart';

class UserSwipe extends StatelessWidget {
  const UserSwipe({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<CommunityProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2.5,
        child: Swiper(
          itemCount: userProvider.users.usuarios.length,
          itemBuilder: (BuildContext context, int index) => Card(
            child: InkWell(
              onTap: () {
                userProvider.userTapped = userProvider.users.usuarios[index];
                Navigator.pushNamed(context, '/userProfile');
              },
              child: userProvider.users.usuarios[index].image != null &&
                      userProvider.users.usuarios[index].image != ""
                  ? Image.network(
                      Config.apiImageBaseUrl +
                          userProvider.users.usuarios[index].image,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/user.png'),
            ),
          ),
          viewportFraction: 0.8,
          loop: true,
          scrollDirection: Axis.horizontal,
          scale: 0.9,
        ),
      ),
    );
  }
}

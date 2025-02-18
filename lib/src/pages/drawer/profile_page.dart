import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/models/connection_status.dart';
import 'package:snowin/src/models/user.dart';
import 'package:snowin/src/pages/community/search_tabs_pages/provider/chat_provider.dart';
import 'package:snowin/src/pages/drawer/widget/profile_image.dart';
import 'package:snowin/src/pages/drawer/widget/profile_loading_image.dart';
import 'package:snowin/src/pages/reports/provider/report_provider.dart';
import 'package:snowin/src/providers/user_provider.dart';
import 'package:snowin/src/widgets/custom_icon_button.dart';
import 'package:snowin/src/widgets/error_connection.dart';
import 'package:snowin/src/widgets/thumbnail.dart';
import '../../widgets/custom_bottom_menu.dart';
import '../../widgets/custom_drawer.dart';
import 'widget/account_detail_tile.dart';
import 'widget/custom_appbar_drawer.dart';
import 'widget/custom_row_data.dart';
import 'widget/custom_user_info_detail.dart';
import 'package:snowin/src/widgets/custom_drop_string.dart';

class ProfilePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldDrawer =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    final size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context);
    final reports = Provider.of<ReportProvider>(context, listen: false);
    final conex = Provider.of<ConnectionStatus>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldDrawer,
      appBar: PreferredSize(
          child: CustomAppbarDrawer(
            scaffoldDrawer: scaffoldDrawer,
            context: context,
            showLogo: false,
            title: "MI PERFIL",
          ),
          preferredSize: Size(double.infinity, 70)),
      body: conex != null && conex.status == Status.HasConnection
          ? SafeArea(
              child: Container(
                alignment: Alignment.center,
                child: ListView(
                  children: <Widget>[
                    Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(color: Colors.black),
                          height: size.height * 0.18,
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20, bottom: 10),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  icon: Icon(Icons.edit, color: Colors.white),
                                  onPressed: () {
                                    _controller.text = user.user.username;
                                    _showPopupProfile(context, user);
                                  },
                                )),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            Align(
                              child: Text(
                                'Nombre de Usuario',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 15),
                              ),
                            ),
                            Align(
                              child: Text(
                                user.user.username,
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 30),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: user.loading
                                  ? UserLoadingImage()
                                  : UserImage(),
                            ),
                          ],
                        )
                      ],
                    ),
                    Align(
                      child: Text(
                        'PERFIL PUBLICO EN SNOWIN',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ..._buildUserInfoData(user, context, _controller),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      child: Text(
                        'MIS REPORTES',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomRowData(
                      title1: 'Publicados',
                      num1: reports.allMyReports.length,
                      title2: 'Puntos',
                      num2: user.user.puntos,
                      title3: 'Ranking',
                      num3: user.user.ranking,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      child: Text(
                        'COMUNIDAD',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomRowData(
                      title1: 'Amigos',
                      num1: 10,
                      title2: 'Mensajes',
                      num2: 5,
                      title3: 'Solicitudes',
                      num3: user.user.ranking,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      child: Text(
                        'MI CUENTA',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: <Widget>[
                          AccountDetailTile(
                            title: 'Notificaciones',
                            action: () =>
                                Navigator.pushNamed(context, '/community'),
                          ),
                          AccountDetailTile(
                            title: 'Privacidad',
                            action: () =>
                                Navigator.pushNamed(context, '/privacy'),
                          ),
                          AccountDetailTile(
                            title: 'Reportar un problema',
                            action: () async {
                              await Provider.of<ChatProvider>(context,
                                      listen: false)
                                  .getConversacion(3);
                              Navigator.pushNamed(context, '/ask',
                                  arguments: context);
                            },
                          ),
                          AccountDetailTile(
                            title: 'Salir de mi cuenta',
                            action: () => null,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ErrorConnection(),
      drawerScrimColor: Colors.black54,
      endDrawer: CustomDrawer(),
      bottomNavigationBar: CustomBottomMenu(
        item: 3,
      ),
    );
  }

  List<Widget> _buildUserInfoData(UserProvider user, BuildContext context,
      TextEditingController controller) {
    List<Widget> elements = List<Widget>();
    final bio = CustomUserInfoDetail(
      action: () {
        controller.text = user.user.biografia;
        _showPopupBio(context, user, controller);
      },
      info: 'Bio',
      title1: user.user.biografia,
      title2: user.user.localidad,
    );
    final practica = CustomUserInfoDetail(
      action: () => _showPopupActividad(context, user),
      info: 'Practica',
      title1: User().getActividadString(user.user.actividad),
    );
    final nivel = CustomUserInfoDetail(
      action: () => _showPopupNivel(context, user),
      info: 'Nivel',
      title1: user.user.nivel,
    );

    elements.add(bio);
    elements.add(practica);
    elements.add(nivel);
    return elements;
  }

  _showPopupProfile(BuildContext context1, UserProvider user) {
    final size = MediaQuery.of(context1).size;
    return showDialog(
      context: context1,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          insetPadding: EdgeInsets.zero,
          title: Text(
            'Editando Foto de perfil',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18)),
              onPressed: () async {
                await user.editUserImage();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Cancelar',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18)),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          content: Container(
            padding: const EdgeInsets.only(top: 20),
            height: 80,
            width: size.width / 1.3,
            child: user.uploading == null
                ? CustomIconButton(
                    icon: Icons.image,
                    iconColor: Color.fromRGBO(159, 159, 159, 1),
                    iconSize: 30.0,
                    borderColor: Color.fromRGBO(74, 74, 73, 1),
                    onPressed: () {
                      ImagePicker.pickImage(source: ImageSource.gallery)
                          .then((image) {
                        if (image != null) {
                          user.uploading = image.path;
                          setState(() {});
                        }
                      }).catchError((error) {
                        print(error);
                      });
                    })
                : InkWell(
                    onTap: () {
                      user.uploading = null;
                      setState(() {});
                    },
                    child: Center(
                      child: Thumbnail(
                        size: size.width * 0.2,
                        path: user.uploading,
                        showDeleteButton: true,
                        onDelete: () {
                          user.uploading = null;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  _showPopupBio(context, UserProvider user, controller) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        title: Text(
          'Editando la Bio',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Aceptar',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18)),
            onPressed: () {
              user.user.biografia = controller.text;
              user.editBio();
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Cancelar',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18)),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: Container(
            padding: const EdgeInsets.only(top: 20),
            height: 80,
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextField(
              style: Theme.of(context).textTheme.headline3,
              maxLines: 3,
              controller: controller,
            )),
      ),
    );
  }

  _showPopupNivel(context, UserProvider user) {
    final size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        title: Text(
          'Editando Nivel',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Aceptar',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18)),
            onPressed: () {
              user.editNivel();
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Cancelar',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18)),
            onPressed: () {
              user.nivelesSelected = user.user.nivel;
              Navigator.of(context).pop();
            },
          )
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: Container(
          padding: const EdgeInsets.only(top: 20),
          height: 80,
          width: MediaQuery.of(context).size.width / 1.3,
          child: CustomDropdowndString(
              width: size.width * 0.9,
              height: 50,
              items: user.niveles,
              value: user.nivelesSelected,
              onChanged: (value) {
                user.nivelesSelected = value;
              }),
        ),
      ),
    );
  }

  _showPopupActividad(context, UserProvider user) {
    final size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        title: Text(
          'Editando la practica',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Aceptar',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18)),
            onPressed: () {
              user.editActividad();
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Cancelar',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18)),
            onPressed: () {
              user.perfilSelected = user.user.actividad;
              Navigator.of(context).pop();
            },
          )
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: Container(
          padding: const EdgeInsets.only(top: 20),
          height: 80,
          width: MediaQuery.of(context).size.width / 1.3,
          child: CustomDropdowndString(
              width: size.width * 0.9,
              height: 50,
              items: user.perfil,
              value: User().getActividadString(user.perfilSelected),
              onChanged: (value) {
                user.perfilSelected = User().getActividadEnum(value);
              }),
        ),
      ),
    );
  }
}

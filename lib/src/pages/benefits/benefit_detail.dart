import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/config/config.dart';
import 'package:snowin/src/pages/benefits/provider/benefit_provider.dart';
import 'package:snowin/src/widgets/custom_appbar_pages.dart';
import 'package:snowin/src/widgets/custom_drawer.dart';
import 'package:snowin/src/widgets/custom_list_info.dart';
import 'package:snowin/src/widgets/custom_bottom_menu.dart';
import 'package:barcode_scan/barcode_scan.dart';

class BenefitDetail extends StatefulWidget {
  BenefitDetail({Key key}) : super(key: key);

  @override
  _BenefitDetailState createState() => _BenefitDetailState();
}

class _BenefitDetailState extends State<BenefitDetail> {
  final GlobalKey<ScaffoldState> scaffoldDrawer =
      new GlobalKey<ScaffoldState>();
  String barcode = '';
  @override
  Widget build(BuildContext context) {
    final benefit = Provider.of<BenefitProvider>(context, listen: false);
    return Scaffold(
      key: scaffoldDrawer,
      appBar: PreferredSize(
          child: CustomAppbarPages(
            scaffoldDrawer: scaffoldDrawer,
            back: true,
            context: context,
            title: "BENEFICIOS",
          ),
          preferredSize: Size(double.infinity, 70)),
      endDrawer: CustomDrawer(),
      bottomNavigationBar: CustomBottomMenu(
        item: 3,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  benefit.benefitTapped.nombre,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  benefit.benefitTapped.descripcion,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                height: 220,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(Config.apiImageBaseUrl +
                            benefit.benefitTapped.imagen))),
              ),
              Positioned(
                right: 20,
                bottom: -20,
                child: FloatingActionButton(
                  heroTag: 'btnScan',
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(Icons.camera_enhance, size: 30),
                  onPressed: scan,
                ),
              ),
            ],
          ),
          CustomListInfo(
              title: 'Detalle',
              info:
                  '${benefit.benefitTapped.nombre} ${benefit.benefitTapped.descripcion}'),
          CustomListInfo(
            title: 'Modalidad',
            info:
                'Para acceder al beneficio escanea el codigo QR en nuestras tiendas con el boton',
            icon: Icons.camera_enhance,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                'Usa este beneficio y suma 10 puntos!',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future scan() async {
    try {
      ScanResult result = await BarcodeScanner.scan();
      setState(() {
        barcode = result.rawContent;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          barcode = 'Necesitamos acceso a la camara para continuar.';
        });
      } else {
        setState(() => barcode = 'Error desconocido: $e');
      }
    } on FormatException {
      setState(() => barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => barcode = 'Error desconocido: $e');
    }
  }
}

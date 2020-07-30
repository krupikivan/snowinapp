import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/benefits/provider/benefit_provider.dart';
import 'package:snowin/src/widgets/custom_textfield.dart';

class BenefitFilterDialog extends StatelessWidget {
  final Size size;
  TextEditingController controllerTitle = TextEditingController(text: '');

  BenefitFilterDialog({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final benefit = Provider.of<BenefitProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: size.width * 0.9,
        height: size.height * 0.3,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 55),
              child: ListTile(
                  title: Text('Descuento'),
                  subtitle: CustomTextField(
                      onlyDigits: true,
                      width: size.width * 0.9,
                      controller: controllerTitle,
                      onChanged: (value) => benefit.discount =
                          value == "" ? 0 : int.parse(value))),
            ),
            ListTile(
              title: Text(
                'Filtros',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              trailing: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    benefit.clearFilter();
                    Navigator.of(context).pop(false);
                  }),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.2),
                child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //cancelar
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: const Text(
                          'CANCELAR',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.black87,
                        onPressed: () {
                          benefit.clearFilter();
                          Navigator.of(context).pop(false);
                        },
                      ),
                      //aplicar filtros
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: const Text(
                          'FILTRAR',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          benefit.fetchBenefits(fromFilter: true);
                          Navigator.of(context).pop(false);
                        },
                      ),
                      //Traer todos
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: const Text(
                          'TODOS',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          benefit.clearFilter();
                          benefit.fetchBenefits(fromFilter: true);
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

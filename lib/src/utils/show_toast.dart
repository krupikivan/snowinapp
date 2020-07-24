import 'package:snowin/src/widgets/toast.dart';

class Show {
  final String msg;

  Show(this.msg);

  void showMessage(String msg) {
    ShowToast().show(msg, 5);
  }
}

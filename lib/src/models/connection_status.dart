import 'package:equatable/equatable.dart';

enum Status { NoConnection, HasConnection }

class ConnectionStatus extends Equatable {
  final Status status;
  ConnectionStatus({this.status});
  @override
  List<Object> get props => [status];

  @override
  bool operator ==(o) {
    var areEqual = o is ConnectionStatus && o.status == status;
    return areEqual;
  }

  @override
  int get hashCode => status.hashCode;
}

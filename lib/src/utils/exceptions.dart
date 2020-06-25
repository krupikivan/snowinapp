import 'dart:io';



/// Enumerador de tipos de Exceptions
enum ExceptionTypes {Parameters, Services, Decode, StatusCode}



/// Enumerador de niveles de importancia de las Exceptions
enum ExceptionLevelsType {Notice, Warning, Error}



/// Clase para las Exceptions relacionadas con los parámetros incompletos
class ParametersException implements IOException {
  final String message;

  const ParametersException(this.message);

  ExceptionLevelsType get level => ExceptionLevelsType.Error;
  ExceptionTypes get type => ExceptionTypes.Parameters;

  String toString() {
    var b = new StringBuffer();
    b.write(message);

    return b.toString();
  }
}



/// Clase para las Exceptions relacionadas con los servicios Web
class ServicesException implements IOException {
  final String message;
  final int code;

  const ServicesException(this.message, {this.code});

  ExceptionLevelsType get level => ExceptionLevelsType.Error;
  ExceptionTypes get type => ExceptionTypes.Services;

  String toString() {
    var b = new StringBuffer();
    if (code != null) {
      b.write('($code): ');
    }
    b.write(message);

    return b.toString();
  }
}



/// Clase para las Exceptions relacionadas con la decodificación de la respuesta
class DecodeException implements IOException {
  final String message;

  const DecodeException(this.message);

  ExceptionLevelsType get level => ExceptionLevelsType.Error;
  ExceptionTypes get type => ExceptionTypes.Decode;

  String toString() {
    var b = new StringBuffer();
    b.write(message);

    return b.toString();
  }
}



/// Clase para las Exceptions relacionadas con el codigo de estado de las respuestas de servicios
class StatusCodeException implements IOException {
  final String message;

  const StatusCodeException(this.message);

  ExceptionLevelsType get level => ExceptionLevelsType.Error;
  ExceptionTypes get type => ExceptionTypes.StatusCode;

  String toString() {
    var b = new StringBuffer();
    b.write(message);

    return b.toString();
  }
}




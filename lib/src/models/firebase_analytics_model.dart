import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));
String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  String itemId;
  String itemName;
  String itemCategory;
  int quantity;
  double price;
  double value;
  String currency;
  String origin;
  String itemLocationId;
  String destination;
  String startDate;
  String endDate;

  CartModel(
      {this.itemId,
      this.itemName,
      this.itemCategory,
      this.quantity,
      this.price,
      this.value,
      this.currency,
      this.origin,
      this.itemLocationId,
      this.destination,
      this.startDate,
      this.endDate});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      currency: json["currency"],
      value: json["value"],
      itemId: json["itemId"],
      itemName: json["itemName"],
      itemCategory: json["itemCategory"],
      quantity: json["quantity"],
      price: json["price"],
      origin: json["origin"],
      itemLocationId: json["itemLocationId"],
      destination: json["destination"],
      startDate: json["startDate"],
      endDate: json["endDate"]
      /*
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        */
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "value": value,
        "itemId": itemId,
        "itemName": itemName,
        "itemCategory": itemCategory,
        "quantity": quantity,
        "price": price,
        "origin": origin,
        "itemLocationId": itemLocationId,
        "destination": destination,
        "startDate": startDate,
        "endDate": endDate
        /*
        "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        */
      };
}

WishlistModel wishlistModelFromJson(String str) =>
    WishlistModel.fromJson(json.decode(str));
String wishlistModelToJson(WishlistModel data) => json.encode(data.toJson());

class WishlistModel {
  String itemId;
  String itemName;
  String itemCategory;
  int quantity;
  double price;
  double value;
  String currency;
  String itemLocationId;

  WishlistModel(
      {this.itemId,
      this.itemName,
      this.itemCategory,
      this.quantity,
      this.price,
      this.value,
      this.currency,
      this.itemLocationId});

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
      currency: json["currency"],
      value: json["value"],
      itemId: json["itemId"],
      itemName: json["itemName"],
      itemCategory: json["itemCategory"],
      quantity: json["quantity"],
      price: json["price"],
      itemLocationId: json["itemLocationId"]);

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "value": value,
        "itemId": itemId,
        "itemName": itemName,
        "itemCategory": itemCategory,
        "quantity": quantity,
        "price": price,
        "itemLocationId": itemLocationId
      };
}

BeginCheckoutModel beginCheckoutModelFromJson(String str) =>
    BeginCheckoutModel.fromJson(json.decode(str));
String beginCheckoutModelToJson(BeginCheckoutModel data) =>
    json.encode(data.toJson());

class BeginCheckoutModel {
  double value;
  String currency;
  String transactionId;
  int numberOfNights;
  int numberOfRooms;
  int numberOfPassengers;
  String origin;
  String destination;
  String startDate;
  String endDate;
  String travelClass;

  BeginCheckoutModel(
      {this.value,
      this.currency,
      this.transactionId,
      this.numberOfNights,
      this.numberOfRooms,
      this.numberOfPassengers,
      this.origin,
      this.destination,
      this.startDate,
      this.endDate,
      this.travelClass});

  factory BeginCheckoutModel.fromJson(Map<String, dynamic> json) =>
      BeginCheckoutModel(
          value: json["value"],
          currency: json["currency"],
          transactionId: json["transactionId"],
          numberOfNights: json["numberOfNights"],
          numberOfRooms: json["numberOfRooms"],
          numberOfPassengers: json["numberOfPassengers"],
          origin: json["origin"],
          destination: json["destination"],
          startDate: json["startDate"],
          endDate: json["endDate"],
          travelClass: json["travelClass"]);

  Map<String, dynamic> toJson() => {
        "value": value,
        "currency": currency,
        "transactionId": transactionId,
        "numberOfNights": numberOfNights,
        "numberOfRooms": numberOfRooms,
        "numberOfPassengers": numberOfPassengers,
        "origin": origin,
        "destination": destination,
        "startDate": startDate,
        "endDate": endDate,
        "travelClass": travelClass
      };
}

LogCampaignDetailsModel logCampaignDetailsModelFromJson(String str) =>
    LogCampaignDetailsModel.fromJson(json.decode(str));
String logCampaignDetailsModelToJson(LogCampaignDetailsModel data) =>
    json.encode(data.toJson());

class LogCampaignDetailsModel {
  String source;
  String medium;
  String campaign;
  String term;
  String content;
  String aclid;
  String cp1;

  LogCampaignDetailsModel(
      {this.source,
      this.medium,
      this.campaign,
      this.term,
      this.content,
      this.aclid,
      this.cp1});

  factory LogCampaignDetailsModel.fromJson(Map<String, dynamic> json) =>
      LogCampaignDetailsModel(
          source: json["source"],
          medium: json["medium"],
          campaign: json["campaign"],
          term: json["term"],
          content: json["content"],
          aclid: json["aclid"],
          cp1: json["cp1"]);

  Map<String, dynamic> toJson() => {
        "source": source,
        "medium": medium,
        "campaign": campaign,
        "term": term,
        "content": content,
        "aclid": aclid,
        "cp1": cp1
      };
}

LogEcommercePurchaseModel logEcommercePurchaseModelFromJson(String str) =>
    LogEcommercePurchaseModel.fromJson(json.decode(str));
String logEcommercePurchaseModelToJson(LogEcommercePurchaseModel data) =>
    json.encode(data.toJson());

class LogEcommercePurchaseModel {
  String currency;
  double value;
  String transactionId;
  double tax;
  double shipping;
  String coupon;
  String location;
  int numberOfNights;
  int numberOfRooms;
  int numberOfPassengers;
  String origin;
  String destination;
  String startDate;
  String endDate;
  String travelClass;

  LogEcommercePurchaseModel({
    this.currency,
    this.value,
    this.transactionId,
    this.tax,
    this.shipping,
    this.coupon,
    this.location,
    this.numberOfNights,
    this.numberOfRooms,
    this.numberOfPassengers,
    this.origin,
    this.destination,
    this.startDate,
    this.endDate,
    this.travelClass,
  });

  factory LogEcommercePurchaseModel.fromJson(Map<String, dynamic> json) =>
      LogEcommercePurchaseModel(
        currency: json["currency"],
        value: json["value"].toDouble(),
        transactionId: json["transactionId"],
        tax: json["tax"].toDouble(),
        shipping: json["shipping"].toDouble(),
        coupon: json["coupon"],
        location: json["location"],
        numberOfNights: json["numberOfNights"],
        numberOfRooms: json["numberOfRooms"],
        numberOfPassengers: json["numberOfPassengers"],
        origin: json["origin"],
        destination: json["destination"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        travelClass: json["travelClass"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "value": value,
        "transactionId": transactionId,
        "tax": tax,
        "shipping": shipping,
        "coupon": coupon,
        "location": location,
        "numberOfNights": numberOfNights,
        "numberOfRooms": numberOfRooms,
        "numberOfPassengers": numberOfPassengers,
        "origin": origin,
        "destination": destination,
        "startDate": startDate,
        "endDate": endDate,
        "travelClass": travelClass,
      };
}

LogPresentOfferModel logPresentOfferModelFromJson(String str) =>
    LogPresentOfferModel.fromJson(json.decode(str));
String logPresentOfferModelToJson(LogPresentOfferModel data) =>
    json.encode(data.toJson());

class LogPresentOfferModel {
  String itemId;
  String itemName;
  String itemCategory;
  int quantity;
  double price;
  double value;
  String currency;
  String itemLocationId;

  LogPresentOfferModel({
    this.itemId,
    this.itemName,
    this.itemCategory,
    this.quantity,
    this.price,
    this.value,
    this.currency,
    this.itemLocationId,
  });

  factory LogPresentOfferModel.fromJson(Map<String, dynamic> json) =>
      LogPresentOfferModel(
        itemId: json["itemId"],
        itemName: json["itemName"],
        itemCategory: json["itemCategory"],
        quantity: json["quantity"],
        price: json["price"].toDouble(),
        value: json["value"].toDouble(),
        currency: json["currency"],
        itemLocationId: json["itemLocationId"],
      );

  Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "itemName": itemName,
        "itemCategory": itemCategory,
        "quantity": quantity,
        "price": price,
        "value": value,
        "currency": currency,
        "itemLocationId": itemLocationId,
      };
}

LogSearchModel logSearchModelFromJson(String str) =>
    LogSearchModel.fromJson(json.decode(str));
String logSearchModelToJson(LogSearchModel data) => json.encode(data.toJson());

class LogSearchModel {
  String searchTerm;
  int numberOfNights;
  int numberOfRooms;
  int numberOfPassengers;
  String origin;
  String destination;
  String startDate;
  String endDate;
  String travelClass;

  LogSearchModel({
    this.searchTerm,
    this.numberOfNights,
    this.numberOfRooms,
    this.numberOfPassengers,
    this.origin,
    this.destination,
    this.startDate,
    this.endDate,
    this.travelClass,
  });

  factory LogSearchModel.fromJson(Map<String, dynamic> json) => LogSearchModel(
      searchTerm: json["searchTerm"],
      numberOfNights: json["numberOfNights"],
      numberOfRooms: json["numberOfRooms"],
      numberOfPassengers: json["numberOfPassengers"],
      origin: json["origin"],
      destination: json["destination"],
      startDate: json["startDate"],
      endDate: json["endDate"],
      travelClass: json["travelClass"]);

  Map<String, dynamic> toJson() => {
        "searchTerm": searchTerm,
        "numberOfNights": numberOfNights,
        "numberOfRooms": numberOfRooms,
        "numberOfPassengers": numberOfPassengers,
        "origin": origin,
        "destination": destination,
        "startDate": startDate,
        "endDate": endDate,
        "travelClass": travelClass
      };
}

LogViewItemModel logViewItemModelFromJson(String str) =>
    LogViewItemModel.fromJson(json.decode(str));
String logViewItemModelToJson(LogViewItemModel data) =>
    json.encode(data.toJson());

class LogViewItemModel {
  String itemId;
  String itemName;
  String itemCategory;
  String itemLocationId;
  double price;
  int quantity;
  String currency;
  double value;
  String flightNumber;
  int numberOfPassengers;
  int numberOfRooms;
  int numberOfNights;
  String origin;
  String destination;
  String startDate;
  String endDate;
  String searchTerm;
  String travelClass;

  LogViewItemModel({
    this.itemId,
    this.itemName,
    this.itemCategory,
    this.itemLocationId,
    this.price,
    this.quantity,
    this.currency,
    this.value,
    this.flightNumber,
    this.numberOfPassengers,
    this.numberOfRooms,
    this.numberOfNights,
    this.origin,
    this.destination,
    this.startDate,
    this.endDate,
    this.searchTerm,
    this.travelClass,
  });

  factory LogViewItemModel.fromJson(Map<String, dynamic> json) =>
      LogViewItemModel(
        itemId: json["itemId"],
        itemName: json["itemName"],
        itemCategory: json["itemCategory"],
        itemLocationId: json["itemLocationId"],
        price: json["price"].toDouble(),
        quantity: json["quantity"],
        currency: json["currency"],
        value: json["value"].toDouble(),
        flightNumber: json["flightNumber"],
        numberOfPassengers: json["numberOfPassengers"],
        numberOfRooms: json["numberOfRooms"],
        numberOfNights: json["numberOfNights"],
        origin: json["origin"],
        destination: json["destination"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        searchTerm: json["searchTerm"],
        travelClass: json["travelClass"],
      );

  Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "itemName": itemName,
        "itemCategory": itemCategory,
        "itemLocationId": itemLocationId,
        "price": price,
        "quantity": quantity,
        "currency": currency,
        "value": value,
        "flightNumber": flightNumber,
        "numberOfPassengers": numberOfPassengers,
        "numberOfRooms": numberOfRooms,
        "numberOfNights": numberOfNights,
        "origin": origin,
        "destination": destination,
        "startDate": startDate,
        "endDate": endDate,
        "searchTerm": searchTerm,
        "travelClass": travelClass,
      };
}

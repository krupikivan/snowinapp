import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:snowin/src/models/firebase_analytics_model.dart';

class FirebaseAnalyticsProvider {
  static FirebaseAnalytics analytics = FirebaseAnalytics();

  static final FirebaseAnalyticsProvider _instancia =
      new FirebaseAnalyticsProvider._internal();

  factory FirebaseAnalyticsProvider() {
    return _instancia;
  }

  FirebaseAnalyticsProvider._internal();

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> sendAnalyticsEvent(
      String name, Map<String, dynamic> myParameters) async {
    await analytics.logEvent(
      name: name,
      parameters: myParameters,
    );
  }

  Future<void> setUserId(String userId) async {
    await analytics.setUserId(userId);
  }

  Future<void> setCurrentScreen(
      String screenName, String screenClassOverride) async {
    await analytics.setCurrentScreen(
      screenName: screenName,
      screenClassOverride: screenClassOverride,
    );
  }

  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    await analytics.setAnalyticsCollectionEnabled(enabled);
  }

  Future<void> setSessionTimeoutDuration(int milliseconds) async {
    await analytics.android?.setSessionTimeoutDuration(milliseconds);
  }

  Future<void> setUserProperty(String name, String value) async {
    await analytics.setUserProperty(name: name, value: value);
  }

  //All Event Types
  Future<void> logAddPaymentInfo() async {
    await analytics.logAddPaymentInfo();
  }

  Future<void> logAddToCart(CartModel cart) async {
    await analytics.logAddToCart(
        itemId: cart.itemId,
        itemName: cart.itemName,
        itemCategory: cart.itemCategory,
        quantity: cart.quantity,
        price: cart.price,
        value: cart.value,
        currency: cart.currency,
        origin: cart.origin,
        itemLocationId: cart.itemLocationId,
        destination: cart.destination,
        startDate: cart.startDate,
        endDate: cart.endDate);
  }

  Future<void> logAddToWishlist(WishlistModel wishlist) async {
    await analytics.logAddToWishlist(
        itemId: wishlist.itemId,
        itemName: wishlist.itemName,
        itemCategory: wishlist.itemCategory,
        quantity: wishlist.quantity,
        price: wishlist.price,
        value: wishlist.value,
        currency: wishlist.currency,
        itemLocationId: wishlist.itemLocationId);
  }

  Future<void> logAppOpen() async {
    await analytics.logAppOpen();
  }

  Future<void> logBeginCheckout(BeginCheckoutModel beginCheckout) async {
    await analytics.logBeginCheckout(
        value: beginCheckout.value,
        currency: beginCheckout.currency,
        transactionId: beginCheckout.transactionId,
        numberOfNights: beginCheckout.numberOfNights,
        numberOfRooms: beginCheckout.numberOfRooms,
        numberOfPassengers: beginCheckout.numberOfPassengers,
        origin: beginCheckout.origin,
        destination: beginCheckout.destination,
        startDate: beginCheckout.startDate,
        endDate: beginCheckout.endDate,
        travelClass: beginCheckout.travelClass);
  }

  Future<void> logCampaignDetails(
      LogCampaignDetailsModel logCampaignDetails) async {
    await analytics.logCampaignDetails(
        source: logCampaignDetails.source,
        medium: logCampaignDetails.medium,
        campaign: logCampaignDetails.campaign,
        term: logCampaignDetails.term,
        content: logCampaignDetails.content,
        aclid: logCampaignDetails.aclid,
        cp1: logCampaignDetails.cp1);
  }

  Future<void> logEarnVirtualCurrency(
      String virtualCurrencyName, double value) async {
    await analytics.logEarnVirtualCurrency(
      virtualCurrencyName: virtualCurrencyName,
      value: value,
    );
  }

  Future<void> logEcommercePurchase(
      LogEcommercePurchaseModel logEcommercePurchase) async {
    await analytics.logEcommercePurchase(
      currency: logEcommercePurchase.currency,
      value: logEcommercePurchase.value,
      transactionId: logEcommercePurchase.transactionId,
      tax: logEcommercePurchase.tax,
      shipping: logEcommercePurchase.shipping,
      coupon: logEcommercePurchase.coupon,
      location: logEcommercePurchase.location,
      numberOfNights: logEcommercePurchase.numberOfNights,
      numberOfRooms: logEcommercePurchase.numberOfRooms,
      numberOfPassengers: logEcommercePurchase.numberOfPassengers,
      origin: logEcommercePurchase.origin,
      destination: logEcommercePurchase.destination,
      startDate: logEcommercePurchase.startDate,
      endDate: logEcommercePurchase.endDate,
      travelClass: logEcommercePurchase.travelClass,
    );
  }

  Future<void> logGenerateLead(String currency, double value) async {
    await analytics.logGenerateLead(
      currency: currency,
      value: value,
    );
  }

  Future<void> logJoinGroup(String groupId) async {
    await analytics.logJoinGroup(groupId: groupId);
  }

  Future<void> logLevelUp(int level, String character) async {
    await analytics.logLevelUp(
      level: level,
      character: character,
    );
  }

  Future<void> logLogin() async {
    await analytics.logLogin();
    print('logLogin Firebase Analytics succeeded');
  }

  Future<void> logPostScore(int score, int level, String character) async {
    await analytics.logPostScore(
      score: score,
      level: level,
      character: character,
    );
  }

  Future<void> logPresentOffer(LogPresentOfferModel logPresentOffer) async {
    await analytics.logPresentOffer(
        itemId: logPresentOffer.itemId,
        itemName: logPresentOffer.itemName,
        itemCategory: logPresentOffer.itemCategory,
        quantity: logPresentOffer.quantity,
        price: logPresentOffer.price,
        value: logPresentOffer.value,
        currency: logPresentOffer.currency,
        itemLocationId: logPresentOffer.itemLocationId);
  }

  Future<void> logPurchaseRefund(
      String currency, double value, String transactionId) async {
    await analytics.logPurchaseRefund(
      currency: currency,
      value: value,
      transactionId: transactionId,
    );
  }

  Future<void> logSearch(LogSearchModel logSearch) async {
    await analytics.logSearch(
        searchTerm: logSearch.searchTerm,
        numberOfNights: logSearch.numberOfNights,
        numberOfRooms: logSearch.numberOfRooms,
        numberOfPassengers: logSearch.numberOfPassengers,
        origin: logSearch.origin,
        destination: logSearch.destination,
        startDate: logSearch.startDate,
        endDate: logSearch.endDate,
        travelClass: logSearch.travelClass);
  }

  Future<void> logSelectContent(String contentType, String itemId) async {
    await analytics.logSelectContent(
      contentType: contentType,
      itemId: itemId,
    );
  }

  Future<void> logShare(
      String contentType, String itemId, String method) async {
    await analytics.logShare(
        contentType: contentType, itemId: itemId, method: method);
  }

  Future<void> logSignUp(String signUpMethod) async {
    await analytics.logSignUp(signUpMethod: signUpMethod);
  }

  Future<void> logSpendVirtualCurrency(
      String itemName, String virtualCurrencyName, num value) async {
    await analytics.logSpendVirtualCurrency(
      itemName: itemName,
      virtualCurrencyName: virtualCurrencyName,
      value: value,
    );
  }

  Future<void> logTutorialBegin() async {
    await analytics.logTutorialBegin();
  }

  Future<void> logTutorialComplete() async {
    await analytics.logTutorialComplete();
  }

  Future<void> logUnlockAchievement(String id) async {
    await analytics.logUnlockAchievement(id: id);
  }

  Future<void> logViewItem(LogViewItemModel logViewItem) async {
    await analytics.logViewItem(
        itemId: logViewItem.itemId,
        itemName: logViewItem.itemName,
        itemCategory: logViewItem.itemCategory,
        itemLocationId: logViewItem.itemLocationId,
        price: logViewItem.price,
        quantity: logViewItem.quantity,
        currency: logViewItem.currency,
        value: logViewItem.value,
        flightNumber: logViewItem.flightNumber,
        numberOfPassengers: logViewItem.numberOfPassengers,
        numberOfRooms: logViewItem.numberOfRooms,
        numberOfNights: logViewItem.numberOfNights,
        origin: logViewItem.origin,
        destination: logViewItem.destination,
        startDate: logViewItem.startDate,
        endDate: logViewItem.endDate,
        searchTerm: logViewItem.searchTerm,
        travelClass: logViewItem.travelClass);
  }

  Future<void> logViewItemList(String itemCategory) async {
    await analytics.logViewItemList(
      itemCategory: itemCategory,
    );
  }

  Future<void> logViewSearchResults(String searchTerm) async {
    await analytics.logViewSearchResults(searchTerm: searchTerm);
  }
}

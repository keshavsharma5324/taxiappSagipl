class ManageCardResponse {
  String? message;
  List<CardBean>? data;
  bool? isSuccess;

  ManageCardResponse({this.message, this.data, this.isSuccess});

  ManageCardResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <CardBean>[];
      json['data'].forEach((v) {
        data!.add(new CardBean.fromJson(v));
      });
    }
    isSuccess = json['is_success'];
  }
}

class CardBean {
  int? id;
  int? passengerId;
  int? setDefault;
  String? stripeCustomerId;
  int? isUsed;
  String? cardNumber;
  String? cvv;
  String? ownerName;
  String? cardId;
  String? cardBrand;
  String? cardLast4Digit;
  String? cardExpiryMonth;
  String? cardExpiryYear;
  String? createdAt;
  String? updatedAt;
  bool? isDefault = false;

  CardBean(
      {this.id,
        this.passengerId,
        this.setDefault,
        this.stripeCustomerId,
        this.isUsed,
        this.cardNumber,
        this.cvv,
        this.ownerName,
        this.cardId,
        this.cardBrand,
        this.cardLast4Digit,
        this.cardExpiryMonth,
        this.cardExpiryYear,
        this.createdAt,
        this.updatedAt,
      this.isDefault});

  CardBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    passengerId = json['passenger_id'];
    setDefault = json['set_default'];
    stripeCustomerId = json['stripe_customer_id'];
    isUsed = json['is_used'];
    cardNumber = json['card_last_4_digit'];//card_number'];
    cvv = '***';//json['cvv'];
    ownerName = json['owner_name'];
    cardId = json['card_id'];
    cardBrand = json['card_brand'];
    cardLast4Digit = json['card_last_4_digit'];
    cardExpiryMonth = json['card_expiry_month'];
    cardExpiryYear = json['card_expiry_year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDefault = json['set_default'] == 1;
  }
}
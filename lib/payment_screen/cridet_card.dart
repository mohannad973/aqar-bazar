import 'package:aqar_bazar/services/payment-service.dart';
import 'package:credit_card/credit_card_form.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

class CreditCards extends StatefulWidget {
  @override
  _CreditCardsState createState() => _CreditCardsState();
}

class _CreditCardsState extends State<CreditCards> {
  String cardNumber = "";
  String expireDate = "";
  String cardHolderName = "";
  String cvvCode = "";
  bool isCvvFocused = false;
  CreditCard card ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
             CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expireDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              height: 200,
              width: MediaQuery.of(context).size.width,
              animationDuration: Duration(milliseconds: 1000),
            ),
            new OutlineButton(
              child: Text(
                'Proceed to Pay',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: null,
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CreditCardForm(
                  onCreditCardModelChange: onModelChanged,
                ),
              ),

            ),
            Padding(
              padding: const EdgeInsets.only(bottom:20.0),
              child: RaisedButton.icon(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context)
                          .size
                          .width /
                          3,
                      vertical: 10),
                  onPressed: ()  async{


                  },
                  icon: Icon(
                    Icons.attach_money,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Pay",
                    style:
                    TextStyle(color: Colors.white),
                  ),
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(15.0),
                  )),
            )
          ],
        ),
      ),
    );

  }
  void onModelChanged(CreditCardModel model){
    setState(() {
      cardNumber =model.cardNumber;
      expireDate = model.expiryDate;
      cardHolderName = model.cardHolderName;
      cvvCode = model.cvvCode;
      isCvvFocused = model.isCvvFocused;
    });
  }
}

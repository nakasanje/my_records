import 'package:paystack_flutter/paystack_flutter.dart';


//function

void startPayment() async {
  PaystackTransaction transaction = PaystackTransaction()
    ..amountInKobo = 500000 // Amount in kobo (e.g., 5000 kobo = ₦50)
    ..email = 'user@example.com' // Customer's email address
    ..reference = DateTime.now().millisecondsSinceEpoch.toString(); // Unique reference for the transaction

  Charge charge = await PaystackFlutter.chargeCard(context, transaction: transaction);
  if (charge.status == true) {
    // Payment successful
    // Update your booking status or perform any other action
  } else {
    // Payment failed
    // Handle the error or display an error message
  }
}

//method
@override
void initState() {
  super.initState();
  PaystackFlutter.initialize(publicKey: 'YOUR_PUBLIC_KEY');
}

///button
RaisedButton(
  onPressed: startPayment,
  child: Text('Make Payment'),
),

///https://paystack.com/pay/bookdoctor
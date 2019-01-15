Paytabs ios library sample
========
![Paytabs-ios-library-v3.0.0](https://img.shields.io/badge/Paytabs%20android%20library-v3.0.0-green.svg)

For more information please see [the website][1].


Download
--------

Download [the latest .framework and resources.bundle](sdk/iOSSDK_21102018.zip):

Read the documentation to know how to integrate your application with the library
[documentation v3.0](docs/paytabs-ios-sdk-3.0.pdf)

```groovy
implementation project(':paytabs_sdk-v3.0.0')
```

Static framework requires at minimum deployment target 9.0.

You have to include the following dependencies in your podfile:
```groovy
  pod 'BIObjCHelpers'
  pod 'AFNetworking'
  pod 'Mantle'
  pod 'Reachability'
  pod 'SDWebImage'
  pod 'DGActivityIndicatorView'
  pod 'Lockbox'
  pod 'YLGIFImage'
  pod 'SBJson'
  pod 'PINCache'
  pod 'IQKeyboardManager'
```

Pay now
--------
```java
Intent in = new Intent(getApplicationContext(), PayTabActivity.class);
in.putExtra(PaymentParams.MERCHANT_EMAIL, "merchant-email@example.com"); //this a demo account for testing the sdk
in.putExtra(PaymentParams.SECRET_KEY,"secret key");//Add your Secret Key Here
in.putExtra(PaymentParams.LANGUAGE,PaymentParams.ENGLISH);
in.putExtra(PaymentParams.TRANSACTION_TITLE, "Test Paytabs android library");
in.putExtra(PaymentParams.AMOUNT, 5.0);

in.putExtra(PaymentParams.CURRENCY_CODE, "BHD");
in.putExtra(PaymentParams.CUSTOMER_PHONE_NUMBER, "009733");
in.putExtra(PaymentParams.CUSTOMER_EMAIL, "customer-email@example.com");
in.putExtra(PaymentParams.ORDER_ID, "123456");
in.putExtra(PaymentParams.PRODUCT_NAME, "Product 1, Product 2");

//Billing Address
in.putExtra(PaymentParams.ADDRESS_BILLING, "Flat 1,Building 123, Road 2345");
in.putExtra(PaymentParams.CITY_BILLING, "Manama");
in.putExtra(PaymentParams.STATE_BILLING, "Manama");
in.putExtra(PaymentParams.COUNTRY_BILLING, "BHR");
in.putExtra(PaymentParams.POSTAL_CODE_BILLING, "00973"); //Put Country Phone code if Postal code not available '00973'

//Shipping Address
in.putExtra(PaymentParams.ADDRESS_SHIPPING, "Flat 1,Building 123, Road 2345");
in.putExtra(PaymentParams.CITY_SHIPPING, "Manama");
in.putExtra(PaymentParams.STATE_SHIPPING, "Manama");
in.putExtra(PaymentParams.COUNTRY_SHIPPING, "BHR");
in.putExtra(PaymentParams.POSTAL_CODE_SHIPPING, "00973"); //Put Country Phone code if Postal code not available '00973'

//Payment Page Style
in.putExtra(PaymentParams.PAY_BUTTON_COLOR, "#2474bc");
in.putExtra(PaymentParams.THEME, PaymentParams.THEME_LIGHT);

//Tokenization
in.putExtra(PaymentParams.IS_TOKENIZATION, true);
startActivityForResult(in, PaymentParams.PAYMENT_REQUEST_CODE);
```

Paytabs
--------
[Support][2] | [Terms of Use][3] | [Privacy Policy][4]




 [1]: https://dev.paytabs.com/docs-apis/#android-sdk
 [2]: https://www.paytabs.com/en/support/
 [3]: https://www.paytabs.com/en/terms-of-use/
 [4]: https://www.paytabs.com/en/privacy-policy/

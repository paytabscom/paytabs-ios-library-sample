//
//  ViewController.m
//  Sample
//
//  Created by Ramy Sabry on 10/13/19.
//  Copyright © 2019 Paytabs. All rights reserved.
//

#import "ViewController.h"
#import <paytabs-iOS/paytabs_iOS.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)setOnClickPay:(id)sender {
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"Resources" withExtension:@"bundle"]];
    
    PTFWInitialSetupViewController *view = [[PTFWInitialSetupViewController alloc]
                                            initWithBundle:bundle
                                            andWithViewFrame:self.view.frame
                                            andWithAmount:6.0
                                            andWithCustomerTitle:@"Paytabs Sample App"
                                            andWithCurrencyCode:@"USD"
                                            andWithTaxAmount:0
                                            andWithSDKLanguage:@"en"
                                            andWithShippingAddress:@"test test"
                                            andWithShippingCity:@"Juffair"
                                            andWithShippingCountry:@"BHR"
                                            andWithShippingState:@"Manama"
                                            andWithShippingZIPCode:@"00973"
                                            andWithBillingAddress:@"test test"
                                            andWithBillingCity:@"Juffair"
                                            andWithBillingCountry:@"BHR"
                                            andWithBillingState:@"Manama"
                                            andWithBillingZIPCode:@"00973"
                                            andWithOrderID:@"12345"
                                            andWithPhoneNumber:@"+97333109781"
                                            andWithCustomerEmail:@"rhegazy@paytabs.com"
                                            andIsTokenization:NO
                                            andIsPreAuth:NO
                                            andWithMerchantEmail:@"rhegazy@paytabs.com"
                                            andWithMerchantSecretKey:@"BIueZNfPLblJnMmPYARDEoP5x1WqseI3XciX0yNLJ8v7URXTrOw6dmbKn8bQnTUk6ch6L5SudnC8fz2HozNBVZlj7w9uq4Pwg7D1"
                                            andWithAssigneeCode:@"SDK"
                                            andWithThemeColor:[UIColor redColor]
                                            andIsThemeColorLight:YES];
    
    view.didReceiveBackButtonCallback = ^{
        UIViewController *rootViewController = [[[[UIApplication sharedApplication]delegate] window] rootViewController];
        [rootViewController dismissViewControllerAnimated:YES completion:nil];
    };
    
    view.didStartPreparePaymentPage = ^{
        // Start Prepare Payment Page
        // Show loading indicator
    };
    
    view.didFinishPreparePaymentPage = ^{
        // Finish Prepare Payment Page
        // Stop loading indicator
    };
    
    view.didReceiveFinishTransactionCallback = ^(int responseCode, NSString * _Nonnull result, int transactionID, NSString * _Nonnull tokenizedCustomerEmail, NSString * _Nonnull tokenizedCustomerPassword, NSString * _Nonnull token, BOOL transactionState) {
        NSLog(@"Response Code: %i", responseCode);
        NSLog(@"Response Result: %@", result);
        
        // In Case you are using tokenization
        NSLog(@"Tokenization Cutomer Email: %@", tokenizedCustomerEmail);
        NSLog(@"Tokenization Customer Password: %@", tokenizedCustomerPassword);
        NSLog(@"TOkenization Token: %@", token);
    };
    
    [self presentViewController:view animated:true completion:nil];
}
@end

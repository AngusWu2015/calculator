//
//  ViewController.m
//  calculator
//
//  Created by AndyWu on 2018/1/25.
//  Copyright © 2018年 AndyWu. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, wFormula) {
    wFormulaAdding = 15,
    wFormulaSubtracting = 14,
    wFormulaMultplaying = 13,
    wFormulaDividing = 12,
    wFormulaNull = -1
};

@interface ViewController ()
{
    __weak IBOutlet UILabel *sumLab;
    __weak IBOutlet UILabel *addNumLab;
    __weak IBOutlet UILabel *symbolLab;
    NSDecimalNumber *subtotal;
    NSDecimalNumber *calculation;
    BOOL newInit;
    BOOL exponent;
    wFormula formula;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self newNum];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ButtonPressed:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 17: //.
            [self sendNum:sender.tag]; //輸入
            break;
        case 10: //C
            [self newNum];
            break;
        case 11: //±
            newInit = NO;
            exponent = NO;
            formula = sender.tag;
            symbolLab.text = @"±";
            break;
        case 12: //÷
            newInit = NO;
            exponent = NO;
            formula = sender.tag;
            symbolLab.text = @"÷";
            break;
        case 13: //x
            newInit = NO;
            exponent = NO;
            formula = sender.tag;
            symbolLab.text = @"x";
            break;
        case 14: //-
            newInit = NO;
            exponent = NO;
            formula = sender.tag;
            symbolLab.text = @"-";
            break;
        case 15: //+
            newInit = NO;
            exponent = NO;
            formula = sender.tag;
            symbolLab.text = @"+";
            break;
        case 16: //=
            newInit = NO;
            exponent = NO;
            [self Subtotal];
            break;
        
            
            break;
        case 21:
            
            break;
        case 22:
            break;
        case 23:
            break;
        case 24:
            break;
        default:
            break;
    }
}
//輸入
-(void)sendNum:(NSUInteger)tag{
    NSString *tmp =[NSString stringWithFormat:@"%li",(long)tag];
    if(tag == 17) {
        if (exponent) {
            return;
        }
        tmp = @".";
        exponent = YES;
    }
    UILabel *tmpLab = addNumLab;
    
    if (newInit) {
        tmpLab = sumLab;
    }
    NSString *tmpStr =[NSString stringWithFormat:@"%@%@",tmpLab.text,tmp];
    if (![tmp isEqualToString:@"."] && exponent && ![tmpStr containsString:@"."]) {
        tmpStr =[NSString stringWithFormat:@"%@.%@",tmpLab.text,tmp];
    }
    NSDecimalNumber * tmpNum = [NSDecimalNumber decimalNumberWithString:tmpStr];
    if (newInit) {
        subtotal = tmpNum;
    }else{
        calculation = tmpNum;
    }
    
    tmpLab.text = tmpNum.stringValue;
}
-(void)Subtotal{
    if(newInit || formula == -1){
        return;
    }
    NSDecimalNumber *tmpNum = subtotal;
    switch (formula) {
        case wFormulaAdding:
            tmpNum = [subtotal decimalNumberByAdding:calculation];
            break;
        case wFormulaDividing:
            tmpNum = [subtotal decimalNumberByDividingBy:calculation];
            break;
        case wFormulaMultplaying:
            tmpNum = [subtotal decimalNumberByMultiplyingBy:calculation];
            break;
        case wFormulaSubtracting:
            tmpNum = [subtotal decimalNumberBySubtracting:calculation];
            break;
        default:
            break;
    }
    subtotal = tmpNum;
    sumLab.text = tmpNum.stringValue;
    addNumLab.text = @"";
    symbolLab.text = @"";
    calculation = 0;
    exponent = NO;
    formula = wFormulaNull;
}
-(void)newNum{
    sumLab.text = @"0";
    addNumLab.text = @"";
    symbolLab.text = @"";
    subtotal = 0;
    calculation = 0;
    newInit = YES;
    exponent = NO;
    formula = wFormulaNull;
}

@end

//
//  ViewController.h
//  ParseXmlToRealizeChooseCityDemo
//
//  Created by zhanggui on 15/7/25.
//  Copyright (c) 2015年 zhanggui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,NSXMLParserDelegate>

- (IBAction)getAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@end


//
//  ViewController.m
//  JSONGetProvinceCityAndAreaDemo
//
//  Created by zhanggui on 15/7/25.
//  Copyright (c) 2015年 zhanggui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    
    NSArray *provinceArr,*cityArr,*areaArr;
       NSString *seletedStr;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    provinceArr = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    cityArr = [[provinceArr objectAtIndex:0] objectForKey:@"cities"];
    areaArr = [[cityArr objectAtIndex:0] objectForKey:@"areas"];
}
#pragma mark - UIPickerViewDelegate

/**
 
 *返回每一列的数据个数
 
 */

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    if (component==0) {
        
        return [provinceArr count];
        
    }else if(component==1)
        
    {
        
        return [cityArr count];
        
    }else
        
    {
        
        return [areaArr count];
        
    }
    
}

/**
 
 *返回pickerView分几列，因为是省市区选择，所以分3列
 
 */

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 3;
    
}

/**
 
 *触发的事件
 
 */

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    if (component==0) {
        
        cityArr = [[provinceArr objectAtIndex:row] objectForKey:@"cities"];
        
        [pickerView selectRow:0 inComponent:1 animated:NO];
        
        [self.myPickerView reloadComponent:1];
        
        if ([cityArr count]!=0) {
            
            areaArr = [[cityArr objectAtIndex:0] objectForKey:@"areas"];
            
            [pickerView selectRow:0 inComponent:2 animated:NO];
            
            [pickerView reloadComponent:2];
            
            
            
        }
        
    }
    
    else if (component==1)
        
    {
        
        areaArr = [[cityArr objectAtIndex:row] objectForKey:@"areas"];
        
        [pickerView selectRow:0 inComponent:2 animated:NO];
        
        [pickerView reloadComponent:2];
        
    }

    UILabel *pro = (UILabel *)[self pickerView:_myPickerView viewForRow:[pickerView selectedRowInComponent:0] forComponent:0 reusingView:nil];
    UILabel *cit =(UILabel *)[self pickerView:_myPickerView viewForRow:[pickerView selectedRowInComponent:1] forComponent:1 reusingView:nil];
    UILabel *are = (UILabel *)[self pickerView:_myPickerView viewForRow:[pickerView selectedRowInComponent:2] forComponent:2 reusingView:nil];
    seletedStr =[NSString stringWithFormat:@"%@%@%@",pro.text,cit.text,are.text];
    
}



/**
 
 *通过自定义view去显示pickerView中的内容,这样做的好处是可以自定义的调整pickerView中显示内容的格式
 
 */

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    
    UILabel *myView = nil;
    
    myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)];
    
    myView.textAlignment = NSTextAlignmentCenter;
    
    myView.font = [UIFont systemFontOfSize:15];         //用label来设置字体大小
    
    if (component==0) {
        
        myView.text =[[provinceArr objectAtIndex:row] objectForKey:@"state"];
        
    }else if (component==1)
        
    {
        
        myView.text =[[cityArr objectAtIndex:row] objectForKey:@"city"];
        
    }else
        
    {
        
        myView.text =[areaArr objectAtIndex:row];
        
    }
    
    return myView;
    
}


#pragma mark - Button Method
- (IBAction)showAction:(UIButton *)sender {
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"选中结果" message:seletedStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [aler show];
}
@end

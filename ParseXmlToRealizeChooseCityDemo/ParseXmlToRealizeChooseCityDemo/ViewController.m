//
//  ViewController.m
//  ParseXmlToRealizeChooseCityDemo
//
//  Created by zhanggui on 15/7/25.
//  Copyright (c) 2015年 zhanggui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableDictionary *province,*city;
    NSMutableArray *provinceArr,*cityArr,*areaArr;
    NSString *tempProvince,*tempCity,*tempArea;

    NSArray *finalProvinceArr,*finalCityArr,*finalAreaArr;
    
    
    NSString *seletedStr;
}



@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    NSString *xmlFilePath = [[NSBundle mainBundle]pathForResource:@"province_data" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:xmlFilePath];
    NSXMLParser *xmlParser = [[NSXMLParser alloc]initWithData:data];
    xmlParser.delegate = self;
    province = [NSMutableDictionary new];
    city = [NSMutableDictionary new];
    provinceArr = [NSMutableArray new];
    cityArr = [NSMutableArray new];
    [xmlParser parse];
  
    
    finalProvinceArr = [province allKeys];
    
    NSDictionary *tempCityDic = [province objectForKey:[finalProvinceArr objectAtIndex:0]];
    finalCityArr = [tempCityDic allKeys];
    

    finalAreaArr = [tempCityDic objectForKey:[finalCityArr objectAtIndex:0]];
}
#pragma mark - xmlParseDelegateMethod
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"province"]) {
        tempProvince = [attributeDict objectForKey:@"name"];
    }
    if ([elementName isEqualToString:@"city"]) {
        tempCity = [attributeDict objectForKey:@"name"];
        areaArr = [NSMutableArray new];
    }else if ([elementName isEqualToString:@"district"]) {
        [areaArr addObject:[attributeDict objectForKey:@"name"]];
    }
 }
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"city"]) {
        NSMutableArray *temp =[[NSMutableArray alloc] initWithArray:areaArr] ;
        [city setValue:temp forKey:tempCity];
        [areaArr removeAllObjects];
    }else if ([elementName isEqualToString:@"province"]) {
        NSDictionary *tempDic = [[NSDictionary alloc] initWithDictionary:city];
        [province setValue:tempDic forKey:tempProvince];
        [city removeAllObjects];
    
    }
}


#pragma mark - UIPickerViewDeletate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component==0) {
        return [finalProvinceArr count];
    }else if (component==1) {
        return [finalCityArr count];
    }else {
        return [finalAreaArr count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component==0) {
        return finalProvinceArr[row];
    }else if (component==1) {
        return finalCityArr[row];
    }else
    {
        return finalAreaArr[row];
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component==0) {
        finalCityArr =[[province objectForKey:[finalProvinceArr objectAtIndex:row]] allKeys];
        [pickerView selectRow:0 inComponent:1 animated:NO];
        [pickerView reloadComponent:1];
        
        if ([finalCityArr count]!=0) {
             NSString *selectedProvince = [self pickerView:pickerView titleForRow:[pickerView selectedRowInComponent:0] forComponent:0];
             NSString *selectedCity = [self pickerView:pickerView titleForRow:[pickerView selectedRowInComponent:1] forComponent:1];
            finalAreaArr = [[province objectForKey:selectedProvince] objectForKey:selectedCity];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            [pickerView reloadComponent:2];
        }
    }else if (component==1) {
        NSString *selectedProvince = [self pickerView:pickerView titleForRow:[pickerView selectedRowInComponent:0] forComponent:0];
        NSString *selectedCity = [self pickerView:pickerView titleForRow:[pickerView selectedRowInComponent:1] forComponent:1];
        finalAreaArr = [[province objectForKey:selectedProvince] objectForKey:selectedCity] ;
        [pickerView selectRow:0 inComponent:2 animated:NO];
        [pickerView reloadComponent:2];
//        finalAreaArr = [province objectForKey:[province objectForKey:<#(id)#>]];
    }
    NSString *pro =[self pickerView:pickerView titleForRow:[pickerView selectedRowInComponent:0] forComponent:0];
    NSString *cit =[self pickerView:pickerView titleForRow:[pickerView selectedRowInComponent:1] forComponent:1];
    NSString *are = [self pickerView:pickerView titleForRow:[pickerView selectedRowInComponent:2] forComponent:2];
    seletedStr =[NSString stringWithFormat:@"%@%@%@",pro,cit,are];
}
#pragma mark - UIButton Method
- (IBAction)getAction:(UIButton *)sender {
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"选中结果" message:seletedStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [aler show];
}
@end

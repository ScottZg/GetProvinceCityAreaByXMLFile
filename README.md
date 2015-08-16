# GetProvinceCityAreaByXMLFile
一个简单的小例子，通过一个xml文件去实现选择省市区      
关键是用了XML解析器的代理方法。具体相关代码如下：

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

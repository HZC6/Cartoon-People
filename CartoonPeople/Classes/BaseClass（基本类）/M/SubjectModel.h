//
//  SubjectModel.h
//  CartoonPeople
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//
/*
 "subcategoryName": "",
 "subcategoryId": 0,
 "subcategoryImgUrl": "http://mhfm7.tel.cdndm5.com/tag/category/phb.jpg",
 "categoryType": 4,
 "skipType": 7,
 "skipParam": {},
 "isHideInSearch": 1
 */
#import <Foundation/Foundation.h>

@interface SubjectModel : NSObject
/**类型名字 **/
@property(nonatomic,strong)NSString *subcategoryName;
/**id**/
@property(nonatomic,assign)NSInteger subcategoryId;
/**图片的url**/
@property(nonatomic,strong)NSString *subcategoryImgUrl;

@end

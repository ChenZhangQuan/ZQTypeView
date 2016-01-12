//
//  ZQScrollView.h
//  ZQJiemian
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 陈樟权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQTypeView : UIView

@property(nonatomic,copy)NSArray *types;

@property(nonatomic,copy)void(^operation)(NSString* itemOne,NSString* itemTwo);

-(void)moveToTypeItem:(NSString*)typeItem;

@end

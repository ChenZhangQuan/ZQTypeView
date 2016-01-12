//
//  ZQScrollView.m
//  ZQJiemian
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 陈樟权. All rights reserved.
//

#import "ZQTypeView.h"
#define showTypeNum 3
@interface ZQTypeView()

@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)UIButton *moreBtn;
@property(nonatomic,strong)NSMutableArray *typeBtns;
@property(nonatomic,strong)UIButton *selectedBtn;
@property(nonatomic,weak)UIView *slider;

@end

@implementation ZQTypeView

-(NSMutableArray*)typeBtns{
    if (_typeBtns == nil) {
        _typeBtns = [NSMutableArray array];
    }
    return _typeBtns;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UIView *slider = [[UIView alloc] init];
        [self.scrollView addSubview:slider];
        slider.backgroundColor = [UIColor redColor];
        self.slider = slider;
//        
//        UIButton *moreBtn = [[UIButton alloc] init];
//        [self addSubview:moreBtn];
//        self.moreBtn = moreBtn;
////        moreBtn.backgroundColor = [UIColor redColor];
////        moreBtn.imageView.contentMode = UIViewContentModeScaleToFill;
//        [moreBtn setImage:[UIImage imageNamed:@"top_navigation_back_s"] forState:UIControlStateNormal];
//        moreBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
//        [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UIView *slider = [[UIView alloc] init];
        [self.scrollView addSubview:slider];
        slider.backgroundColor = [UIColor redColor];
        self.slider = slider;

    }
    return self;
}

-(void)moreBtnClick:(UIButton *)button{
    NSLog(@"moreBtnClick");
    button.selected = !button.selected;
    [UIView animateWithDuration:0.25 animations:^{
        if (button.selected) {
            button.imageView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        }else{
            button.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
    }];
}

-(void)setTypes:(NSArray *)types{
    _types = [types copy];
    
    for (int i = 0; i < types.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        NSString *string = types[i];
//        [btn setBackgroundColor:[UIColor blueColor]];
//        btn.x = -100;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:string forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        [self.typeBtns addObject:btn];
//        NSLog(@"%@,%@",typeItem.name,typeItem.unistr);
    }
    UIButton *btn = self.typeBtns.firstObject;
    [UIView setAnimationsEnabled:NO];
    [self typeBtnClick:btn];
    [UIView setAnimationsEnabled:YES];
    
    
    [self setNeedsLayout];
    
}

-(void)moveToTypeItem:(NSString*)string{
    for (UIButton *typeButton in self.typeBtns) {
        if ([string isEqualToString:[typeButton titleForState:UIControlStateNormal]]) {
            if (self.selectedBtn == typeButton) {
                return;
            }
            [self selectedBtn:typeButton];
            return;
        }
    }
}

-(void)typeBtnClick:(UIButton *)typeBtn{
    
    if (self.operation) {
        self.operation([typeBtn titleForState:UIControlStateNormal],[self.selectedBtn titleForState:UIControlStateNormal]);
    }

    [self selectedBtn:typeBtn];
    
}

-(void)selectedBtn:(UIButton*)typeBtn{
    self.selectedBtn.selected = NO;
    self.selectedBtn = typeBtn;
    self.selectedBtn.selected = YES;
    
    
    [UIView animateWithDuration:0.3 animations:^{
//        self.slider.centerX = self.selectedBtn.centerX;
        self.slider.center  = CGPointMake(self.selectedBtn.center.x, self.slider.center.y);
        CGFloat visableRectW = self.scrollView.frame.size.width;
        CGFloat visableRectH = self.scrollView.frame.size.height;
        CGFloat visableRectX = self.selectedBtn.center.x - visableRectW / 2;
        CGFloat visableRectY = 0;
        
        CGRect visableRect = CGRectMake(visableRectX, visableRectY, visableRectW, visableRectH);
        [self.scrollView scrollRectToVisible:visableRect animated:YES];
    }];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    CGFloat btnH = self.frame.size.height;
//    CGFloat btnW = 0;
//    CGFloat btnY = 0;
//    CGFloat btnX = self.frame.size.width - btnW;
//    self.moreBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    self.scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

    CGFloat typeButtonW = 70;
    CGFloat typeButtonH = self.frame.size.height - 2;

    for (int i = 0; i < self.types.count; i++) {
        UIButton *button = self.typeBtns[i];
        button.frame = CGRectMake(typeButtonW * i, 2, typeButtonW, typeButtonH);
    }
    
    CGFloat sliderW = typeButtonW * 0.7;
    CGFloat sliderX = typeButtonW *0.5 - sliderW * 0.5;
    self.slider.frame = CGRectMake(sliderX, typeButtonH, sliderW, 2);
    
    
    self.scrollView.contentSize = CGSizeMake(typeButtonW * self.types.count, typeButtonH);
    
}


@end

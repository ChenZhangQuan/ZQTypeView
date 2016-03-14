//
//  ViewController.m
//  zqtest
//
//  Created by czq on 16/1/12.
//  Copyright © 2016年 陈樟权. All rights reserved.
//

#import "ViewController.h"
#import "ZQTypeView.h"
@interface ViewController ()

@property (assign, nonatomic) NSInteger index;
@property (strong,nonatomic) NSArray *arr;
@property (weak, nonatomic) IBOutlet ZQTypeView *typeView;


- (IBAction)pre:(id)sender;
- (IBAction)next:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 0;
    NSArray *arr = @[@"标题1",@"标题2",@"标题3",@"标题4",@"标题5",@"标题6",@"标题7",@"标题8"];
    self.arr = arr;
    self.typeView.types = arr;
    self.typeView.operation = ^(NSString* itemOne,NSString* itemTwo){
        NSLog(@"从%@动到了%@",itemTwo,itemOne);
    };
}



- (IBAction)pre:(id)sender {
    self.index --;
    if (self.index < 0) {
        self.index = 0;
    }
    [self.typeView moveToTypeItem:self.arr[self.index]];

}

- (IBAction)next:(id)sender {
    self.index ++;
    if (self.index == self.arr.count) {
        self.index = self.arr.count - 1;
    }
    [self.typeView moveToTypeItem:self.arr[self.index]];
}
@end

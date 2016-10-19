//
//  ViewController.m
//  ZSMenuBtnViewDemo
//
//  Created by Kael on 2016/10/18.
//  Copyright © 2016年 创维海通. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)menuBtnAction:(id)sender {
    
    [_menuBtn changeToArrowView:!_menuBtn.selected];
    _menuBtn.selected = !_menuBtn.selected;
    [_menuBtn setIsDrawView:NO];
}
@end

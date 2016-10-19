//
//  ViewController.h
//  ZSMenuBtnViewDemo
//
//  Created by Kael on 2016/10/18.
//  Copyright © 2016年 创维海通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuBtnView.h"
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MenuBtnView *menuBtn;

- (IBAction)menuBtnAction:(id)sender;

@end


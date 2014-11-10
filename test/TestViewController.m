//
//  TestViewController.m
//  test
//
//  Created by Hakon Hanesand on 11/9/14.
//  Copyright (c) 2014 Hakon Hanesand. All rights reserved.
//

#import "TestViewController.h"
#import "FirebaseMutableArray.h"

@interface TestViewController ()
@property (weak, nonatomic) IBOutlet UITextField *addTextField;
@property (weak, nonatomic) IBOutlet UITextField *removeTextField;
@property (weak, nonatomic) IBOutlet UITextField *changeTextField;
@property (weak, nonatomic) IBOutlet UITextField *changeIndex;
@property (weak, nonatomic) IBOutlet UITextField *addIndexTextField;
@property (weak, nonatomic) IBOutlet UITextField *addIndex;
@property (weak, nonatomic) IBOutlet UITextField *arrayDisplay;
@property (nonatomic) Firebase *firebase;
@property (nonatomic) FirebaseMutableArray *array;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _firebase = [[Firebase alloc] initWithUrl:@"https://thinktank.firebaseio.com/lines"];
    
    _array = [[FirebaseMutableArray alloc] initWithFirebaseRef:_firebase];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapAddButton:(id)sender {
    [_array addObject:_addTextField.text];
    _addTextField.text = @"";
}

- (IBAction)didTapRemoveButton:(id)sender {
    [_array removeObjectFromArrayAtIndex:[_removeTextField.text intValue]];
    _removeTextField.text = @"";
}

- (IBAction)didTapChangeButton:(id)sender {
    [_array setObjectAtIndex:[_changeIndex.text intValue] toObject:_changeTextField.text];
    _changeTextField.text = @"";
    _changeIndex.text = @"";
}

- (IBAction)didTapAddIndexButton:(id)sender {
    [_array insertObject:_addIndexTextField.text inArrayAtIndex:[_addIndex.text intValue]];
    _addIndex.text = @"";
    _addIndexTextField.text = @"";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

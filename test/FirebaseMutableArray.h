//
//  FirebaseMutableArray.h
//  test
//
//  Created by Hakon Hanesand on 11/9/14.
//  Copyright (c) 2014 Hakon Hanesand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>

@interface FirebaseMutableArray : NSObject

- (instancetype)initWithFirebaseRef:(Firebase *)firebase;

- (BOOL)addObject:(id)object;
- (BOOL)insertObject:(id)object inArrayAtIndex:(int)index;
- (BOOL)removeObjectFromArrayAtIndex:(int)index;
- (BOOL)setObjectAtIndex:(int)index toObject:(id)object;

@end
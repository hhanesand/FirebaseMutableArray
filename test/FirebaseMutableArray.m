//
//  FirebaseMutableArray.m
//  test
//
//  Created by Hakon Hanesand on 11/9/14.
//  Copyright (c) 2014 Hakon Hanesand. All rights reserved.
//

#import "FirebaseMutableArray.h"

@interface FirebaseMutableArray()
@property (nonatomic) Firebase *firebase;
@property (nonatomic) NSMutableDictionary *array;
@property (nonatomic) NSMutableArray *keys;
@end

@implementation FirebaseMutableArray

- (instancetype) initWithFirebaseRef:(Firebase *) ref {
    if (self = [super init]) {
        _firebase = ref;
        _array = [NSMutableDictionary new];
        _keys = [NSMutableArray new];
        
        [_firebase observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
            [_array setObject:snapshot.value forKey:snapshot.name];
            [_keys addObject:snapshot.name];
            NSLog(@"Child added with value %@ and key %@", snapshot.value, snapshot.name);
        }];
        
        [_firebase observeEventType:FEventTypeChildChanged withBlock:^(FDataSnapshot *snapshot) {
            [_array setObject:snapshot.value forKey:snapshot.name];
            NSLog(@"Child with key %@ changed to %@", snapshot.name, snapshot.value);
        }];
        
        [_firebase observeEventType:FEventTypeChildRemoved withBlock:^(FDataSnapshot *snapshot) {
            [_array removeObjectForKey:snapshot.name];
            [_keys removeObject:snapshot.name];
            NSLog(@"Child with key %@ deleted", snapshot.name);
        }];
    }
    
    return self;
}

- (BOOL)addObject:(id)object {
    if (![FirebaseMutableArray checkType:object]) {
        NSLog(@"Warning unsuported object type");
        return NO;
    }
    
    Firebase *child = [_firebase childByAutoId];
    [child setValue:object];
    [_keys addObject:child.name];
    return YES;
}

- (BOOL)insertObject:(id)object inArrayAtIndex:(int)index {
    if (![FirebaseMutableArray checkType:object]) {
        NSLog(@"Warning unsuported object type");
        return NO;
    }
    
    if (![self rangeCheck:index]) {
        NSLog(@"Warning out of range access attempt!");
        return NO;
    }
    
    Firebase *child = [_firebase childByAutoId];
    [child setValue:object];
    [_keys insertObject:child.name atIndex:index];
    return YES;
}

- (BOOL)removeObjectFromArrayAtIndex:(int)index {
    if (![self rangeCheck:index]) {
        NSLog(@"Warning out of range access attempt!");
        return NO;
    }
    
    Firebase *child = [_firebase childByAppendingPath:[_keys objectAtIndex:index]];
    [child removeValue];
    [_keys removeObjectAtIndex:index];
    return YES;
}

- (BOOL)setObjectAtIndex:(int)index toObject:(id)obj {
    if (![FirebaseMutableArray checkType:obj]) {
        NSLog(@"Warning unsuported object type");
        return NO;
    }
    
    if (![self rangeCheck:index]) {
        NSLog(@"Warning out of range access attempt!");
        return NO;
    }
    
    Firebase *child = [_firebase childByAppendingPath:[_keys objectAtIndex:index]];
    [child setValue:obj];
    return YES;
}


- (BOOL) rangeCheck:(int) range {
    return [_array count] >= range;
}

+ (BOOL) checkType:(id)obj {
    return [obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]];
}

@end



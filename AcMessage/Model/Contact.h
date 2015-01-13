//
//  Contact.h
//  AcMessage
//
//  Created by liuyang1204 on 14-11-29.
//  Copyright (c) 2014年 pro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * mobile;
@property (nonatomic, retain) NSManagedObject *group;

@end

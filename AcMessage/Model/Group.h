//
//  Group.h
//  AcMessage
//
//  Created by liuyang1204 on 14-11-29.
//  Copyright (c) 2014年 pro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact;

@interface Group : NSManagedObject

@property (nonatomic, retain) NSSet *contacts;
@end

@interface Group (CoreDataGeneratedAccessors)

- (void)addContactsObject:(Contact *)value;
- (void)removeContactsObject:(Contact *)value;
- (void)addContacts:(NSSet *)values;
- (void)removeContacts:(NSSet *)values;

@end

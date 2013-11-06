//
//  database.h
//  Scoala
//
//  Created by CleverSoft on 11/5/13.
//  Copyright (c) 2013 CLEVERSOFT-2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface database : NSObject
-(NSArray *) getMaterii ;
-(NSArray *) getNews;
-(NSArray *) getChild:(NSString *) id_parinte;
-(NSArray *) getMarks:(NSString *) id_copil;
@end

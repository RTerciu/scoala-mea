//
//  database.m
//  Scoala
//
//  Created by CleverSoft on 11/5/13.
//  Copyright (c) 2013 CLEVERSOFT-2. All rights reserved.
//

#import "database.h"
@interface database()
@end


@implementation database
-(NSArray *) executaTransferDateCuServer:(NSString *) link
{

    //cere catre server
    NSURLRequest *cerere=[NSURLRequest requestWithURL:[NSURL URLWithString:link]];
    //primesc raspunsul la cererea sincrona
    NSData *raspuns=[NSURLConnection sendSynchronousRequest:cerere returningResponse:nil error:nil];
    NSError *eroareJson=nil;
    //transform raspunsul din clasa generica NSData intr-un sir specific formatat ca dictionar conform jsonului
    NSArray *data = [NSJSONSerialization JSONObjectWithData:raspuns options:0 error:&eroareJson];
    
    
    return data;

}


-(NSArray *)getNews
{

    NSString *string_auxiliar=[NSString stringWithFormat:@"http://89.149.34.98:85/api/news"];
    return [self executaTransferDateCuServer:string_auxiliar];

}



-(NSArray *) getMaterii
{

    NSString *string_auxiliar=[NSString stringWithFormat:@"http://89.149.34.98:85/api/courses"];
    return [self executaTransferDateCuServer:string_auxiliar];

}

-(NSArray *) getChild:(NSString *)id_parinte
{

    NSString *string_auxiliar=[NSString stringWithFormat:@"http://89.149.34.98:85/catalog/getchild?id=%@",id_parinte];
    return [self executaTransferDateCuServer:string_auxiliar];

}

-(NSArray *) getMarks:(NSString *)id_copil
{

    NSString *string_auxiliar=[NSString stringWithFormat:@"http://89.149.34.98:85/catalog/getmarks?id=%@",id_copil];
    return [self executaTransferDateCuServer:string_auxiliar];

}

@end

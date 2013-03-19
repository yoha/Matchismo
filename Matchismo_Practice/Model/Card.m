//
//  Card.m
//  Matchismo_Practice
//
//  Created by Yohannes Wijaya on 3/13/13.
//  Copyright (c) 2013 Yohannes Wijaya. All rights reserved.
//

#import "Card.h"

@interface Card()
@end

@implementation Card

- (int)match:(NSArray *)aBunchOfCards{
    int score = 0;
    for (Card *card in aBunchOfCards){
        if([card.contents isEqualToString:self.contents]){score = 1;}
   }
    return score;
}

@end

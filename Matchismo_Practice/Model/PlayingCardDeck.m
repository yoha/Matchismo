//
//  PlayingCardDeck.m
//  Matchismo_Practice
//
//  Created by Yohannes Wijaya on 3/13/13.
//  Copyright (c) 2013 Yohannes Wijaya. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (id)init{
    if(self = [super init]){
        for (NSString *suit in [PlayingCard validSuits]){
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++){
                PlayingCard *newCard = [[PlayingCard alloc]init];
                newCard.suit = suit;
                newCard.rank = rank;
                [self addCard:newCard atTop:YES];
            }
        }
    }
    return self;
}

@end

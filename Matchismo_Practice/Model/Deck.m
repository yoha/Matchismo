//
//  Deck.m
//  Matchismo_Practice
//
//  Created by Yohannes Wijaya on 3/13/13.
//  Copyright (c) 2013 Yohannes Wijaya. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

@interface Deck()

@property (nonatomic, strong) NSMutableArray *deck;

@end

@implementation Deck

- (NSMutableArray *)deck{
    if (!_deck){_deck = [[NSMutableArray alloc]init];}
    return _deck;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop{
    if (card){
        if (atTop){[self.deck insertObject:card atIndex:0];}
        else {[self.deck addObject:card];}
    }
}

- (Card *)drawRandomCard{
    Card *randomCard = [[Card alloc]init];
    if ([self.deck count]){
        unsigned int indexFromRandomNumber = arc4random() % [self.deck count];
        randomCard = [self.deck objectAtIndex:indexFromRandomNumber];
        //  or shorter: randomCard = [self.deck[indexFromRandomNumber]];
        [self.deck removeObjectAtIndex:indexFromRandomNumber];
    }
    return randomCard;
}
@end

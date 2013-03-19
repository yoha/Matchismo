//
//  PlayingCardMatching.m
//  Matchismo_Practice
//
//  Created by Yohannes Wijaya on 3/19/13.
//  Copyright (c) 2013 Yohannes Wijaya. All rights reserved.
//

#import "PlayingCardMatching.h"
#import "Card.h"
#import "Deck.h"

@interface PlayingCardMatching()

@property (nonatomic, readwrite) int scoreForMatchingCards;
@property (nonatomic, strong) NSMutableArray *aDeckOfCards; //  of cards

@end

#define MATCHING_BONUS_POINT 4
#define MISMATCHED_PENALTY_POINT 2
#define FLIPPING_COST 1

@implementation PlayingCardMatching

- (NSMutableArray *) aDeckOfCards{
    if (!_aDeckOfCards){_aDeckOfCards = [[NSMutableArray alloc]init];}
    return _aDeckOfCards;
}

#pragma mark - Public Methods

- (void)flipCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    if (card && !card.isUnPlayable){
        if (!card.isFaceUp){
            for (Card *otherCard in self.aDeckOfCards){
                if (otherCard.isFaceUp && !otherCard.isUnPlayable){
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore){
                        card.unPlayable = YES;
                        otherCard.unPlayable = YES;
                        self.scoreForMatchingCards += matchScore * MATCHING_BONUS_POINT;
                    }
                    else{
                        otherCard.faceUp = NO;
                        self.scoreForMatchingCards -= MISMATCHED_PENALTY_POINT;
                    }
                    break;
                }
            }
            self.scoreForMatchingCards -= FLIPPING_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index{
    return index <= [self.aDeckOfCards count] ? self.aDeckOfCards[index] : nil;
}

#pragma mark - Designated Initializer

- (id)initWithTheseManyCards:(NSUInteger)cardsShownOnView
               usingThisDeck:(Deck *)deckOfFiftyTwoCards{
    if (self = [super init]){
        for (int i = 0; i < cardsShownOnView; i++){
            Card *card = [deckOfFiftyTwoCards drawRandomCard];
            if (!card){
                self = nil;
                break;
            }
            else{self.aDeckOfCards[i] = card;}
        }
    }
    return self;
}

@end

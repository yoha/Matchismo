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
@property (nonatomic, strong) NSMutableArray *aSetOfCardsOnTheView; //  of cards
@property (nonatomic, strong, readwrite) NSString *resultForMatchingCards;
@property (nonatomic, strong) NSString *flippedUpOrDown;

@end

#define MATCHING_BONUS_POINT 4
#define MISMATCHED_PENALTY_POINT 2
#define FLIPPING_COST 1

@implementation PlayingCardMatching

// Lazy instantiation.
- (NSMutableArray *)aSetOfCardsOnTheView{
    if (!_aSetOfCardsOnTheView){_aSetOfCardsOnTheView = [[NSMutableArray alloc]init];}
    return _aSetOfCardsOnTheView;
}

#pragma mark - Public Methods

- (void)flipCardAtIndex:(NSUInteger)index withGamingMode:(NSUInteger)gameMode{
    Card *card = [self cardAtIndex:index];
    if (card && !card.isUnPlayable){
        //  As soon as  a card is flipped, we display it to the result label on the View.
        self.flippedUpOrDown = [NSString stringWithFormat:@"%@ is flipped", card.contents];
        self.resultForMatchingCards = !card.isFaceUp ? [self.flippedUpOrDown stringByAppendingString:@" up."] : [self.flippedUpOrDown stringByAppendingString:@" down."];
        
        if (!card.isFaceUp){
            NSMutableArray *aSetOfOpenedCards = [[NSMutableArray alloc]init];
            NSMutableArray *aSetOfOpenedCardsContents = [[NSMutableArray alloc]init];
            
            for (Card *otherCard in self.aSetOfCardsOnTheView){
                if (otherCard.isFaceUp && !otherCard.isUnPlayable){
                    [aSetOfOpenedCards addObject:otherCard];
                    [aSetOfOpenedCardsContents addObject:otherCard.contents];
                }
            }
            
            //  For 2 card game, the value of 'gameMode' is 0 & the number of opened card is 1. For 3 card game, the value of  'gameMode' is 1
            //  & the number of opened card is 2. And so on. The conditional statement executes as long as the number of opened cards match the game mode. 
            if ([aSetOfOpenedCards count] == gameMode + 1){
                int matchScore = [card match:aSetOfOpenedCards];
                
                if (matchScore){
                    card.unPlayable = YES;
                    for (Card *openedCard in aSetOfOpenedCards){openedCard.unPlayable = YES;}
                    self.scoreForMatchingCards += matchScore * MATCHING_BONUS_POINT;
                    self.resultForMatchingCards = [NSString stringWithFormat:@"%@ & %@ matched for %d points.", card.contents, [aSetOfOpenedCardsContents componentsJoinedByString:@" & "], matchScore * MATCHING_BONUS_POINT];
                }
                else{
                    for (Card *openedCard in aSetOfOpenedCards){openedCard.faceUp = NO;}
                    self.scoreForMatchingCards -= MISMATCHED_PENALTY_POINT;
                    self.resultForMatchingCards = [NSString stringWithFormat:@"%@ & %@ mismatched for %d penalty points.", card.contents, [aSetOfOpenedCardsContents componentsJoinedByString:@" & "], MISMATCHED_PENALTY_POINT];
                }
            }
            self.scoreForMatchingCards -= FLIPPING_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index{
    return index <= [self.aSetOfCardsOnTheView count] ? self.aSetOfCardsOnTheView[index] : nil;
}

#pragma mark - Designated Initializer

- (id)initWithTheseManyCards:(NSUInteger)cardsShownOnView usingThisDeck:(Deck *)deckOfFiftyTwoCards{
    if (self = [super init]){
        for (int i = 0; i < cardsShownOnView; i++){
            Card *card = [deckOfFiftyTwoCards drawRandomCard];
            if (!card){
                self = nil;
                break;
            }
            else{self.aSetOfCardsOnTheView[i] = card;}
        }
    }
    return self;
}

@end

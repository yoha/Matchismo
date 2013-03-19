//
//  PlayingCardMatching.h
//  Matchismo_Practice
//
//  Created by Yohannes Wijaya on 3/19/13.
//  Copyright (c) 2013 Yohannes Wijaya. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Card, Deck;

@interface PlayingCardMatching : NSObject

@property (nonatomic, readonly) int scoreForMatchingCards;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

- (id)initWithTheseManyCards:(NSUInteger)cardsShownOnView
               usingThisDeck:(Deck *)deckOfFiftyTwoCards;

@end

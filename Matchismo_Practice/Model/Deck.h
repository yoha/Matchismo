//
//  Deck.h
//  Matchismo_Practice
//
//  Created by Yohannes Wijaya on 3/13/13.
//  Copyright (c) 2013 Yohannes Wijaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Card;

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;

@end

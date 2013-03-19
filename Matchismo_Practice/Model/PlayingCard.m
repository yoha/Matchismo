//
//  PlayingCard.m
//  Matchismo_Practice
//
//  Created by Yohannes Wijaya on 3/13/13.
//  Copyright (c) 2013 Yohannes Wijaya. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

//  Overriding Class' 'match' method for 'playingCardMatching' class 
- (int)match:(NSArray *)aBunchOfCards{
    int matchingScore = 0;
    if ([aBunchOfCards count] == 1){
        PlayingCard *card = [aBunchOfCards lastObject];
        if ([card.suit isEqualToString:self.suit]){matchingScore = 1;}
        else if (card.rank == self.rank){matchingScore = 4;}
    }
    return matchingScore;
}

+ (NSArray *)validRanks{
    static NSArray *validRanks = nil;
    if (!validRanks){validRanks = @[@"?",@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];}
    return validRanks;
}

+ (NSArray *)validSuits{
    static NSArray *validSuits = nil;
    if (!validSuits){validSuits = @[@"♤", @"♧", @"♡", @"♢"];}
    return validSuits;
}

//  >>>@property NSString *suit>>>
@synthesize suit = _suit;

- (NSString *)suit{
    if (!_suit){_suit = [[NSString alloc]init];}
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject:suit]){_suit = suit;}
}   
//  <<<@property NSString *suit<<<

- (void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]){_rank = rank;}
}

+ (NSUInteger)maxRank{
    return [[PlayingCard validRanks] count] - 1;
}

- (NSString *)contents{
    return [[PlayingCard validRanks][self.rank] stringByAppendingString:self.suit];
}

@end

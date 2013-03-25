//
//  PlayingCard.m
//  Matchismo_Practice
//
//  Created by Yohannes Wijaya on 3/13/13.
//  Copyright (c) 2013 Yohannes Wijaya. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

//  Overriding Class' 'match' method for 'playingCardMatching' class.
//  This method can accomodate as many cards as argument & set score multiplier accordingly.
- (int)match:(NSArray *)aBunchOfCards{
    int matchingScore = 0;
    int suitCount = 0;
    int rankCount = 0;
    int scoreMultiplier = [aBunchOfCards count];
    
    //Validating every object in 'aBunchOfCards' are of type 'PlayingCard'
    NSMutableArray *verifiedObjectsArePlayingCards = [[NSMutableArray alloc]init];
    for (id toBeVerifiedCard in aBunchOfCards){
        if ([toBeVerifiedCard isKindOfClass:[PlayingCard class]]){
            [verifiedObjectsArePlayingCards addObject:toBeVerifiedCard];
        }
    }
    
    if ([aBunchOfCards count]){
        for (PlayingCard *card in verifiedObjectsArePlayingCards){
            //  For every matching rank or suit, we tally them.
            if ([card.suit isEqualToString:self.suit]){suitCount++;}
            else if (card.rank == self.rank){rankCount++;}
            //  And we multiply the respective tally by the amount of opened cards.
            //  If the tallies are not equal to the # of opened cards, 'matchingScore' is nil.
            if (suitCount == [verifiedObjectsArePlayingCards count]){matchingScore += 1 * scoreMultiplier;}
            else if (rankCount == [verifiedObjectsArePlayingCards count]){matchingScore += 2 * scoreMultiplier;}
        }
    }
    
    return matchingScore;
}

+ (NSArray *)validRanks{
    static NSArray *validRanks = nil;
    if (!validRanks){validRanks = @[@"?",@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];}
    return validRanks;
}

#pragma mark - Public Method

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

#pragma mark - Public Method

+ (NSUInteger)maxRank{
    return [[PlayingCard validRanks] count] - 1;
}

- (NSString *)contents{
    return [[PlayingCard validRanks][self.rank] stringByAppendingString:self.suit];
}

@end

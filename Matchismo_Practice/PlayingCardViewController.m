//
//  PlayingCardViewController.m
//  Matchismo_Practice
//
//  Created by Yohannes Wijaya on 3/13/13.
//  Copyright (c) 2013 Yohannes Wijaya. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"
#import "Card.h"

@interface PlayingCardViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (nonatomic, strong) Deck *newDeck;
@end

@implementation PlayingCardViewController

- (Deck *)newDeck{
    if (!_newDeck){
        _newDeck = [[PlayingCardDeck alloc]init];
    }
    return _newDeck;
}

- (void)setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", flipCount];
}

- (IBAction)flipCardWhenTapped:(UIButton *)sender{
    if (!sender.isSelected){
        [sender setTitle:[self.newDeck drawRandomCard].contents forState:UIControlStateSelected];
    }
    sender.selected = !sender.isSelected;
    self.flipCount++;
}

@end

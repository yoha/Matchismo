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
#import "PlayingCardMatching.h"

@interface PlayingCardViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic, strong) PlayingCardMatching *cardMatchingGame;
@end

@implementation PlayingCardViewController

- (PlayingCardMatching *)cardMatchingGame{
    if (!_cardMatchingGame){
        _cardMatchingGame = [[PlayingCardMatching alloc]initWithTheseManyCards:[self.cardButtons count]
                                                           usingThisDeck:[[PlayingCardDeck alloc]init]];
    }
    return _cardMatchingGame;
}

- (void)updateView{
    for (UIButton *cardButton in self.cardButtons){
        Card *card = [self.cardMatchingGame cardAtIndex:[self.cardButtons indexOfObject: cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha = card.isUnPlayable ? 0.5 : 1.0;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.cardMatchingGame.scoreForMatchingCards];
    }
}

- (void)setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", flipCount];
}

- (IBAction)flipCardWhenTapped:(UIButton *)sender{
    [self.cardMatchingGame flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    sender.selected = !sender.isSelected;
    self.flipCount++;
    [self updateView];
}

@end

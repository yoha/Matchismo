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
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastScoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) int lastScore;
@property (nonatomic) int matchMode;
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
    self.gameModeLabel.enabled = NO;
    UIImage *playingCardBackImage = [UIImage imageNamed:@"playingCard.jpeg"];
    for (UIButton *cardButton in self.cardButtons){
        Card *card = [self.cardMatchingGame cardAtIndex:[self.cardButtons indexOfObject: cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha = card.isUnPlayable ? 0.5 : 1.0;
        //  Set the perimeter / boundary where 'playingCardBackImage' is allowed to be drawn.
        [cardButton setImageEdgeInsets:UIEdgeInsetsMake(5, 6.25, 5, 6.25)];
        //  Set 'playingCardBackImage' to the back of every card that is not facing up.
        if (!cardButton.selected){
            [cardButton setImage:playingCardBackImage forState:UIControlStateNormal];
        }
        else{[cardButton setImage:nil forState:UIControlStateNormal];}
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.cardMatchingGame.scoreForMatchingCards];
    self.resultLabel.text = self.cardMatchingGame.resultForMatchingCards;
}

- (void)setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flip: %d", flipCount];
}

//  This setter will make every card on the View display 'playingCardBackImage' before the game begins &
//  as soon as the property 'cardButtons' get synthesized. 
- (void)setCardButtons:(NSArray *)cardButtons{
    _cardButtons = cardButtons;
    [self updateView];
}

- (void)displayLastScore{
    self.lastScoreLabel.text = [NSString stringWithFormat:@"Last Score: %d", self.lastScore];
    self.lastScore = self.cardMatchingGame.scoreForMatchingCards;
}

- (IBAction)flipCardWhenTapped:(UIButton *)sender{
    [self.cardMatchingGame flipCardAtIndex:[self.cardButtons indexOfObject:sender]withGamingMode:self.matchMode];
    sender.selected = !sender.isSelected;
    self.flipCount++;
    [self updateView];
    [self displayLastScore];
}

- (IBAction)resetGame:(UIButton *)sender{
    self.cardMatchingGame = nil;
    self.flipCount = 0;
    self.lastScore = 0;
    [self displayLastScore];
    [self updateView];
    self.gameModeLabel.enabled = YES;
}

- (IBAction)gameMode:(UISegmentedControl *)sender {
    //  Since there are only 2 segments, they will return either '0' or '1' for the left and right segment respectively.
    self.matchMode = sender.selectedSegmentIndex;
}
@end

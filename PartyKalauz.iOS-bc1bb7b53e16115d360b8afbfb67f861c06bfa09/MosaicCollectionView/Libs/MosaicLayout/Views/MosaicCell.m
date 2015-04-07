//
//  MosaicDataView.m
//  MosaicCollectionView
//
//  Created by Ezequiel A Becerra on 2/16/13.
//  Copyright (c) 2013 Betzerra. All rights reserved.
//

#import "MosaicCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"

#define kLabelHeight 20
#define kLabelMargin 10
#define kImageViewMargin 0

@interface MosaicCell()
-(void)setup;
@end

@implementation MosaicCell

@synthesize image;

#pragma mark - Private

-(void)setup{
    self.backgroundColor = [UIColor whiteColor];
    
    //  Set image view
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    
    [self addSubview:_imageView];
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_imageView
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:kImageViewMargin];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_imageView
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:-kImageViewMargin];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_imageView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:kImageViewMargin];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_imageView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1
                                                                         constant:-kImageViewMargin];
    
    NSArray *constraints = @[leftConstraint, rightConstraint, topConstraint, bottomConstraint];
    [self addConstraints:constraints];
    
    //  Added black stroke
    self.layer.borderWidth = 3;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.clipsToBounds = YES;
    
    // Added Fader to bottom
    _faderViewBottom = [[UIView alloc] initWithFrame:CGRectZero];
    _gradientBottom = [CAGradientLayer layer];
    _gradientBottom.colors = [NSArray arrayWithObjects:
                              (id)[[[UIColor blackColor] colorWithAlphaComponent:0] CGColor],
                              (id)[[[UIColor blackColor] colorWithAlphaComponent:1]CGColor],
                              nil];
    if([_faderViewBottom.layer.sublayers count])
    {
        CAGradientLayer* oldLayer = [_faderViewBottom.layer.sublayers objectAtIndex:0];
        [_faderViewBottom.layer replaceSublayer:oldLayer with:_gradientBottom];
    }
    else
    {
        [_faderViewBottom.layer insertSublayer:_gradientBottom atIndex:0];
    }
    [self addSubview:_faderViewBottom];
    
    // Added Fader to top
    _faderViewTop = [[UIView alloc] initWithFrame:CGRectZero];
    _gradientTop = [CAGradientLayer layer];
    _gradientTop.colors = [NSArray arrayWithObjects:
                           (id)[[[UIColor blackColor] colorWithAlphaComponent:1]CGColor],
                           (id)[[[UIColor blackColor] colorWithAlphaComponent:0] CGColor],
                           nil];
    if([_faderViewTop.layer.sublayers count])
    {
        CAGradientLayer* oldLayer = [_faderViewTop.layer.sublayers objectAtIndex:0];
        [_faderViewTop.layer replaceSublayer:oldLayer with:_gradientTop];
    }
    else
    {
        [_faderViewTop.layer insertSublayer:_gradientTop atIndex:0];
    }
    [self addSubview:_faderViewTop];
    
    
    //  UILabel for attending
    _attendingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _attendingLabel.textAlignment = NSTextAlignmentLeft;
    _attendingLabel.backgroundColor = [UIColor clearColor];
    _attendingLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    _attendingLabel.textColor = [UIColor whiteColor];
    _attendingLabel.shadowColor = [UIColor blackColor];
    _attendingLabel.shadowOffset = CGSizeMake(1, 1);
    _attendingLabel.numberOfLines = 1;
    [self addSubview:_attendingLabel];
    
    _titleLabel.numberOfLines = 1;
    
    //  UILabel for title
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textAlignment = NSTextAlignmentRight;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.shadowColor = [UIColor blackColor];
    _titleLabel.shadowOffset = CGSizeMake(0, 1);
    _titleLabel.numberOfLines = 1;
    [self addSubview:_titleLabel];
}

#pragma mark - Properties

-(UIImage *)image{
    return _imageView.image;
}

-(void)setImage:(UIImage *)newImage{
    _imageView.image = newImage;
    
    
    
    if (_mosaicData.firstTimeShown){
        _mosaicData.firstTimeShown = NO;
        _imageView.alpha = 0;
        //  Random delay to avoid all animations happen at once
        float millisecondsDelay = (arc4random() % 700) / 1000.0f;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, millisecondsDelay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.6 animations:^{
                _imageView.alpha = 1.0;
            }];
        });
        
    }
}

-(MosaicData *)mosaicData{
    return _mosaicData;
}

-(void)setHighlighted:(BOOL)highlighted{
    
     //  This avoids the animation runs every time the cell is reused
     if (self.isHighlighted != highlighted){
         _imageView.alpha = 0.0;
         [UIView animateWithDuration:0.3 animations:^{
             _imageView.alpha = 1.0;
         }];
     }
    
    [super setHighlighted:highlighted];
}

-(void)setMosaicData:(MosaicData *)newMosaicData{
    
    _mosaicData = newMosaicData;
    
    
    //  Image set
    if ([_mosaicData.imageFilename hasPrefix:@"http://"] ||
        [_mosaicData.imageFilename hasPrefix:@"https://"]){
        //  Download image from the web
      
        NSURL *anURL = [NSURL URLWithString:_mosaicData.imageFilename];
        [_imageView sd_setImageWithURL:anURL];
        
    }else{
        //  Load image from bundle
        self.image = [UIImage imageNamed:@"placeholder.jpg"];
    }
    
    
    //  Title set
    _titleLabel.text = _mosaicData.title;
    
    // Attending set
    
    _attendingLabel.text = [NSString stringWithFormat:@"%@ résztvevő",_mosaicData.attending];
}

#pragma mark - Public

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self setup];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    // Draw top Fader
    _faderViewTop.frame = CGRectMake(0, 0, self.bounds.size.width, 50.0f);
    _gradientTop.frame = _faderViewTop.bounds;
    
    // Draw bottom Fader
    _faderViewBottom.frame = CGRectMake(.0f, self.bounds.size.height-_faderViewBottom.frame.size.height, self.bounds.size.width, 50.0f);
    _gradientBottom.frame = _faderViewBottom.bounds;
    
    
    // Draw attending label
    _attendingLabel.frame = CGRectMake(kLabelMargin,
                                   self.bounds.size.height - kLabelHeight - kLabelMargin,
                                   self.bounds.size.width - kLabelMargin * 2,
                                   kLabelHeight);
    
    // Draw the title label
    _titleLabel.frame = CGRectMake(kLabelMargin,
                                       kLabelMargin,
                                       self.bounds.size.width - kLabelMargin*2,
                                       kLabelHeight);
    
    // Image Shadow properties
    _imageView.layer.shadowOffset = CGSizeMake(8, 8);
    _imageView.layer.shadowColor = [UIColor redColor].CGColor;
    _imageView.layer.shadowOpacity = 1;
}

-(void)prepareForReuse{
    [super prepareForReuse];
    self.image = nil;
}

@end

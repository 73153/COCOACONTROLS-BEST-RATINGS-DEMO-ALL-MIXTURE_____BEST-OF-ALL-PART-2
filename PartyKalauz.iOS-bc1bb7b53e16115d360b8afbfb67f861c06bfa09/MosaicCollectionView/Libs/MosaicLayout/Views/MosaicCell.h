//
//  MosaicDataView.h
//  MosaicCollectionView
//
//  Created by Ezequiel A Becerra on 2/16/13.
//  Copyright (c) 2013 Betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MosaicData.h"

@interface MosaicCell : UICollectionViewCell{
    UIImageView *_imageView;
    UIView *_faderViewBottom;
    CAGradientLayer *_gradientBottom;
    UIView *_faderViewTop;
    CAGradientLayer *_gradientTop;
    MosaicData *_mosaicData;
    UILabel *_titleLabel;
    UILabel *_attendingLabel;
}

@property (strong) UIImage *image;
@property (strong) MosaicData *mosaicData;

@end

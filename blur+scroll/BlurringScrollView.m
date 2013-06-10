//
//   Copyright 2013 Daher Alfawares
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//

#import "BlurringScrollView.h"

@interface BlurringScrollView ()
@property (nonatomic,weak) IBOutlet UIImageView* primaryBackground;
@property (nonatomic,weak) IBOutlet UIImageView* secondaryBackground;
@end

@implementation BlurringScrollView


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.contentSize = CGSizeMake( self.frame.size.width, self.frame.size.height * 1.1 );
}

-(void)setSecondaryBackground:(UIImageView*)secondaryBackground
{
    _secondaryBackground = secondaryBackground;
    
    self.blurringFactor = 0;
}

// scroll
float scroll( float x, float m )
{
    if( x <= 0 )
        return 0;
    
    if( 0 < x && x < m )
        return x / m;
    
    return 1;
}

// alpha
float blur(float x, float m )
{
    if( x <= 0 )
        return 0;
    
    if( 0 < x && x < m )
        return cos( x * m * M_PI_2 - M_PI_2 ) / 2.f;
    
    return 1;
}

-(void)setBlurringFactor:(float)blurringFactor
{
    _blurringFactor = blurringFactor;
    
    float scale = ( self.contentSize.height - self.frame.size.height );
    float x = blurringFactor;
    float m = 0.3f;
    
    float y = scroll( x, m ) * scale;
    float a = blur( x, m ) * scale;
    
    self.contentOffset              = CGPointMake( 0, y );
    self.secondaryBackground.alpha  = a;
}


@end

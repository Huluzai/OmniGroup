// Copyright 2010-2017 Omni Development, Inc. All rights reserved.
//
// This software may only be used and reproduced according to the
// terms in the file OmniSourceLicense.html, which should be
// distributed with this project and can also be found at
// <http://www.omnigroup.com/developer/sourcecode/sourcelicense/>.

#import <OmniUI/OUIColorAttributeInspectorSlice.h>

#import <OmniUI/OUIColorAttributeInspectorWell.h>
#import <OmniUI/OUIInspectorSelectionValue.h>

#import "OUIParameters.h"

RCS_ID("$Id$")

@interface OUIColorAttributeInspectorSlice ()
@property (strong, nonatomic) UIView *bottomSeparator;
@end

@implementation OUIColorAttributeInspectorSlice

@synthesize textWell = _textWell;

- initWithLabel:(NSString *)label;
{
    OBPRECONDITION(![NSString isEmptyString:label]);
    
    if (!(self = [super init]))
        return nil;
    
    self.title = label;
    
    return self;
}


#pragma mark -
#pragma mark UIViewController subclass

- (NSString *)nibName
{
    return nil;
}

- (NSBundle *)nibBundle
{
    return nil;
}

- (void)viewDidLoad;
{
    [super viewDidLoad];
    
    _textWell = [[OUIColorAttributeInspectorWell alloc] init];
    _textWell.translatesAutoresizingMaskIntoConstraints = NO;
    _textWell.style = OUIInspectorTextWellStyleSeparateLabelAndText;
    _textWell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _textWell.cornerType = OUIInspectorWellCornerTypeLargeRadius;
    _textWell.backgroundType = OUIInspectorWellBackgroundTypeNormal;
    _textWell.label = self.title;
    
    [_textWell addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_textWell];

    NSMutableArray *constraintsToActivate = [NSMutableArray array];
    [constraintsToActivate addObject:[self.view.heightAnchor constraintEqualToConstant:kOUIInspectorWellHeight]];
    [constraintsToActivate addObject:[_textWell.leftAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leftAnchor]];
    self.rightMarginLayoutConstraint = [_textWell.rightAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.rightAnchor];
    [constraintsToActivate addObject:self.rightMarginLayoutConstraint];
    [constraintsToActivate addObject:[_textWell.topAnchor constraintEqualToAnchor:self.view.topAnchor]];
    [constraintsToActivate addObject:[_textWell.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]];
    [NSLayoutConstraint activateConstraints:constraintsToActivate];
}

#pragma mark -
#pragma mark OUIInspectorSlice subclass

- (UIView *)contentView;
{
    return self.view;
}

- (void)updateInterfaceFromInspectedObjects:(OUIInspectorUpdateReason)reason;
{
    [super updateInterfaceFromInspectedObjects:reason];
    
    OUIInspectorSelectionValue *selectionValue = self.selectionValue;
    
    OUIColorAttributeInspectorWell *textWell = (OUIColorAttributeInspectorWell *)self.textWell;
    textWell.color = selectionValue.firstValue;
}

@end

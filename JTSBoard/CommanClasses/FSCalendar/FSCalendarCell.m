//
//  FSCalendarCell.m
//  Pods
//
//  Created by Wenchao Ding on 12/3/15.
//
//

#import "FSCalendarCell.h"
#import "FSCalendar.h"
#import "FSCalendarExtensions.h"
#import "FSCalendarDynamicHeader.h"
#import "FSCalendarConstants.h"

@interface FSCalendarCell ()

@property (readonly, nonatomic) UIColor *colorForCellFill;
@property (readonly, nonatomic) UIColor *colorForTitleLabel;
@property (readonly, nonatomic) UIColor *colorForSubtitleLabel;
@property (readonly, nonatomic) UIColor *colorForCellBorder;
@property (readonly, nonatomic) NSArray<UIColor *> *colorsForEvents;
@property (readonly, nonatomic) CGFloat borderRadius;

@end

@implementation FSCalendarCell

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    
    UILabel *label;
    
    UIImageView *imageView;
    
    label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [self.contentView addSubview:label];
    self.titleLabel = label;
    
    label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // shweta
    [self.contentView addSubview:label];
    
    self.subtitleLabel1 = label;
    
    label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // shweta
    [self.contentView addSubview:label];
    
    self.subtitleLabel2 = label;
    
    label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // shweta
    [self.contentView addSubview:label];
    
    self.subtitleLabel3 = label;
    
    label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // shweta
    [self.contentView addSubview:label];
    
    self.subtitleLabel4 = label;

  
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.contentMode = UIViewContentModeBottom|UIViewContentModeCenter;
    [self.contentView addSubview:imageView];
    self.imgEventCounter = imageView;
    
    label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // shweta
    [self.contentView addSubview:label];
    
    self.lblEventCounter = label;
    
    self.clipsToBounds = NO;
    self.contentView.clipsToBounds = NO;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLabel setTextAlignment:NSTextAlignmentLeft];

    [_lblEventCounter setFont:[UIFont boldSystemFontOfSize:9]];

    [_subtitleLabel1 setFont:[UIFont systemFontOfSize:9]];
    [_subtitleLabel2 setFont:[UIFont systemFontOfSize:9]];
    [_subtitleLabel3 setFont:[UIFont systemFontOfSize:9]];
    [_subtitleLabel4 setFont:[UIFont systemFontOfSize:9]];
    
    [_subtitleLabel1 setTextAlignment:NSTextAlignmentLeft];
    [_subtitleLabel2 setTextAlignment:NSTextAlignmentLeft];
    [_subtitleLabel3 setTextAlignment:NSTextAlignmentLeft];
    [_subtitleLabel4 setTextAlignment:NSTextAlignmentLeft];
    
    [_subtitleLabel1 setLineBreakMode:NSLineBreakByCharWrapping];
    [_subtitleLabel2 setLineBreakMode:NSLineBreakByCharWrapping];
    [_subtitleLabel3 setLineBreakMode:NSLineBreakByCharWrapping];
    [_subtitleLabel4 setLineBreakMode:NSLineBreakByCharWrapping];

    
    NSLog(@"%@",_eventList);
    
    _titleLabel.frame = CGRectMake(
                                   10,
                                   5,
                                   self.contentView.fs_width,
                                   15
                                   );
    
    if ([_eventList objectAtIndex:0]) {
        
        _subtitleLabel1.frame = CGRectMake(
                                          3,
                                          30,
                                          self.fs_width - 6,
                                          15
                                          );
        
        _subtitleLabel1.layer.cornerRadius = 5.0;
        _subtitleLabel1.clipsToBounds = true;
        _subtitleLabel1.text = [_eventList objectAtIndex:0];
        _subtitleLabel1.textColor = [UIColor redColor];
        
        [_subtitleLabel setHidden:FALSE];
    }
    if ([_eventList objectAtIndex:1]) {
        
        _subtitleLabel2.frame = CGRectMake(
                                           3,
                                           45,
                                           self.fs_width - 6,
                                           15
                                           );
        
        _subtitleLabel2.layer.cornerRadius = 5.0;
        _subtitleLabel2.clipsToBounds = true;
        _subtitleLabel2.text = [_eventList objectAtIndex:1];
        _subtitleLabel2.textColor = [UIColor purpleColor];
        
        [_subtitleLabel2 setHidden:FALSE];

    }
    if ([_eventList objectAtIndex:2]) {
        
        
        _subtitleLabel3.frame = CGRectMake(
                                           3,
                                           60,
                                           self.fs_width - 6,
                                           15
                                           );
        
        _subtitleLabel3.layer.cornerRadius = 5.0;
        _subtitleLabel3.clipsToBounds = true;
        _subtitleLabel3.text = [_eventList objectAtIndex:3];
        _subtitleLabel3.textColor = [UIColor greenColor];
        
        [_subtitleLabel3 setHidden:FALSE];

    }
    if ([_eventList objectAtIndex:3]) {
        
        _subtitleLabel4.frame = CGRectMake(
                                           3,
                                           75,
                                           self.fs_width - 6,
                                           15
                                           );
        
        _subtitleLabel4.layer.cornerRadius = 5.0;
        _subtitleLabel4.clipsToBounds = true;
        _subtitleLabel4.text = [_eventList objectAtIndex:3];
        _subtitleLabel4.textColor = [UIColor blueColor];
        
        [_subtitleLabel4 setHidden:FALSE];

    }
    
    if (_eventList.count>0) {
        
        _imgEventCounter.frame = CGRectMake(
                                            self.frame.size.width - 30,
                                            self.frame.size.height - 30,
                                            30,
                                            30
                                            );
        
        [_imgEventCounter setImage:[UIImage imageNamed:@"tringle"]];

        [_imgEventCounter setHidden:FALSE];
        
        if (_eventList.count > 1) {
            
            _lblEventCounter.frame = CGRectMake(
                                               self.imgEventCounter.frame.origin.x + 10,
                                               self.imgEventCounter.frame.origin.y + 13,
                                               20,
                                               15
                                               );
            
            _lblEventCounter.layer.cornerRadius = 5.0;
            _lblEventCounter.clipsToBounds = true;
            _lblEventCounter.text = @"+5";
            _lblEventCounter.textColor = [UIColor whiteColor];

            [_lblEventCounter setHidden:FALSE];
        }

    }
    else
    {
        [_imgEventCounter setHidden:TRUE];
    }
  
   
    
    
 
}


#pragma mark - Public

- (void)performSelecting
{
    
/*#define kAnimationDuration FSCalendarDefaultBounceAnimationDuration
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    CABasicAnimation *zoomOut = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomOut.fromValue = @0.3;
    zoomOut.toValue = @1.2;
    zoomOut.duration = kAnimationDuration/4*3;
    CABasicAnimation *zoomIn = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomIn.fromValue = @1.2;
    zoomIn.toValue = @1.0;
    zoomIn.beginTime = kAnimationDuration/4*3;
    zoomIn.duration = kAnimationDuration/4;
    group.duration = kAnimationDuration;
    group.animations = @[zoomOut, zoomIn];
    [self configureAppearance];*/
    
#undef kAnimationDuration
    
}

#pragma mark - Private

- (void)configureAppearance
{
    UIColor *textColor = self.colorForTitleLabel;
    if (![textColor isEqual:_titleLabel.textColor]) {
        _titleLabel.textColor = textColor;
    }
    UIFont *titleFont = self.calendar.appearance.titleFont;
    if (![titleFont isEqual:_titleLabel.font]) {
        _titleLabel.font = titleFont;
    }
   /* if (_subtitle) {
        textColor = self.colorForSubtitleLabel;
        if (![textColor isEqual:_subtitleLabel.textColor]) {
            //_subtitleLabel.textColor = textColor;  //shweta
        }
        titleFont = self.calendar.appearance.subtitleFont;
        if (![titleFont isEqual:_subtitleLabel.font]) {
            //_subtitleLabel.font = titleFont;
            
            _subtitleLabel.font = [UIFont boldSystemFontOfSize:14];

        }
    }*/
    
   
    

}

- (UIColor *)colorForCurrentStateInDictionary:(NSDictionary *)dictionary
{
    if (self.isSelected) {
        if (self.dateIsToday) {
            return dictionary[@(FSCalendarCellStateSelected|FSCalendarCellStateToday)] ?: dictionary[@(FSCalendarCellStateSelected)];
        }
        return dictionary[@(FSCalendarCellStateSelected)];
    }
    if (self.dateIsToday && [[dictionary allKeys] containsObject:@(FSCalendarCellStateToday)]) {
        return dictionary[@(FSCalendarCellStateToday)];
    }
    if (self.placeholder && [[dictionary allKeys] containsObject:@(FSCalendarCellStatePlaceholder)]) {
        return dictionary[@(FSCalendarCellStatePlaceholder)];
    }
    if (self.weekend && [[dictionary allKeys] containsObject:@(FSCalendarCellStateWeekend)]) {
        return dictionary[@(FSCalendarCellStateWeekend)];
    }
    return dictionary[@(FSCalendarCellStateNormal)];
}

#pragma mark - Properties

- (UIColor *)colorForCellFill
{
   /* if (self.selected) {
        return self.preferredFillSelectionColor ?: [self colorForCurrentStateInDictionary:_appearance.backgroundColors];
    }
    return self.preferredFillDefaultColor ?: [self colorForCurrentStateInDictionary:_appearance.backgroundColors];*/
    
    return [UIColor clearColor]; // shweta
}

- (UIColor *)colorForTitleLabel
{
   /* if (self.selected) {
        return self.preferredTitleSelectionColor ?: [self colorForCurrentStateInDictionary:_appearance.titleColors];
    }
    return self.preferredTitleDefaultColor ?: [self colorForCurrentStateInDictionary:_appearance.titleColors];*/
    
    return [UIColor blackColor]; // shweta

}

- (UIColor *)colorForSubtitleLabel
{
   /* if (self.selected) {
        return self.preferredSubtitleSelectionColor ?: [self colorForCurrentStateInDictionary:_appearance.subtitleColors];
    }
    return self.preferredSubtitleDefaultColor ?: [self colorForCurrentStateInDictionary:_appearance.subtitleColors];*/
    
    return [UIColor redColor];  // shweta
}

- (UIColor *)colorForCellBorder
{
    if (self.selected) {
        return _preferredBorderSelectionColor ?: _appearance.borderSelectionColor;
    }
    return _preferredBorderDefaultColor ?: _appearance.borderDefaultColor;
}

- (NSArray<UIColor *> *)colorsForEvents
{
    if (self.selected) {
        return _preferredEventSelectionColors ?: @[_appearance.eventSelectionColor];
    }
    return _preferredEventDefaultColors ?: @[_appearance.eventDefaultColor];
}

- (CGFloat)borderRadius
{
    return _preferredBorderRadius >= 0 ? _preferredBorderRadius : _appearance.borderRadius;
}

#define OFFSET_PROPERTY(NAME,CAPITAL,ALTERNATIVE) \
\
@synthesize NAME = _##NAME; \
\
- (void)set##CAPITAL:(CGPoint)NAME \
{ \
    BOOL diff = !CGPointEqualToPoint(NAME, self.NAME); \
    _##NAME = NAME; \
    if (diff) { \
        [self setNeedsLayout]; \
    } \
} \
\
- (CGPoint)NAME \
{ \
    return CGPointEqualToPoint(_##NAME, CGPointInfinity) ? ALTERNATIVE : _##NAME; \
}

OFFSET_PROPERTY(preferredTitleOffset, PreferredTitleOffset, _appearance.titleOffset);
OFFSET_PROPERTY(preferredSubtitleOffset, PreferredSubtitleOffset, _appearance.subtitleOffset);
OFFSET_PROPERTY(preferredImageOffset, PreferredImageOffset, _appearance.imageOffset);
OFFSET_PROPERTY(preferredEventOffset, PreferredEventOffset, _appearance.eventOffset);

#undef OFFSET_PROPERTY

- (void)setCalendar:(FSCalendar *)calendar
{
    if (![_calendar isEqual:calendar]) {
        _calendar = calendar;
        _appearance = calendar.appearance;
        [self configureAppearance];
    }
}


- (void)setEventList:(NSMutableArray *)eventList
{
    _eventList = eventList;
    NSLog(@"%@",eventList);
}
@end


@interface FSCalendarEventIndicator ()

@property (weak, nonatomic) UIView *contentView;

@property (strong, nonatomic) NSPointerArray *eventLayers;

@end

@implementation FSCalendarEventIndicator

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:view];
        self.contentView = view;
       
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat diameter = MIN(MIN(self.fs_width, self.fs_height),FSCalendarMaximumEventDotDiameter);
    self.contentView.fs_height = self.fs_height;
    self.contentView.fs_width = (self.numberOfEvents*2-1)*diameter;
    self.contentView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}




@end


@implementation FSCalendarBlankCell

- (void)configureAppearance {}

@end




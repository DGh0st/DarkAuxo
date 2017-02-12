#include <UIKit/UIKit.h>

@interface CALayer (DarkAuxo)
-(void)setContentsMultiplyColor:(CGColorRef)arg1 ;
@end

@interface UITableViewWrapperView : UIScrollView
@end

@interface UITableView (DarkAuxo)
-(id)_wrapperView;
@end

%group BeforeTen
%hook SBControlCenterContainerView
-(id)dynamicsContainerView{
	UIView *result = %orig;
	[result setBackgroundColor:[UIColor blackColor]];
	return result;
}
%end

%hook SBControlCenterContentContainerView
-(id)backdropView{
	UIView *result = %orig;
	[result setBackgroundColor:[UIColor blackColor]];
	return result;
}
%end

%hook SBNotificationCenterViewController
-(id)backdropView{
	UIView *result = %orig;
	[result setBackgroundColor:[UIColor blackColor]];
	return result;
}
%end
%end

%group TenPlus
%hook CCUIControlCenterPagePlatterView
-(id)initWithDelegate:(id)arg1 {
	id result = %orig(arg1);
	UIImageView *whiteLayerView = MSHookIvar<UIImageView *>(self, "_whiteLayerView");
	CALayer *layer = [whiteLayerView layer];
	[layer setContentsMultiplyColor:[[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.0] CGColor]];
	[whiteLayerView setBackgroundColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.0]];
	return result;
}

-(void)layoutSubviews {
	%orig;
	UIImageView *whiteLayerView = MSHookIvar<UIImageView *>(self, "_whiteLayerView");
	CALayer *layer = [whiteLayerView layer];
	[layer setContentsMultiplyColor:[[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.0] CGColor]];
	[whiteLayerView setBackgroundColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.0]];
}
%end

%hook MPAVRoutingViewController
-(void)viewWillAppear:(BOOL)arg1 {
	%orig(arg1);
	UITableView *tableView = MSHookIvar<UITableView *>(self, "_tableView");
	UITableViewWrapperView *wrapperView = [tableView _wrapperView];
	[wrapperView setBackgroundColor:[UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:0.75]];
}
%end
%end

%ctor {
	if (%c(CCUIControlCenterPagePlatterView)) {
		%init(TenPlus);
	} else {
		%init(BeforeTen);
	}
}
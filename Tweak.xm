%hook SBControlCenterContainerView
-(id)dynamicsContainerView{
	UIView *result = %orig;
	[result setBackgroundColor:[%c(UIColor) blackColor]];
	return result;
}
%end

%hook SBControlCenterContentContainerView
-(id)backdropView{
	UIView *result = %orig;
	[result setBackgroundColor:[%c(UIColor) blackColor]];
	return result;
}
%end

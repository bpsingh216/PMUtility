/*!
 *	PMTSLUtility.h.m
 *	Utility
 *	
 *	Created by B.P.SINGH on 26/06/14.
 *	Copyright 2014 ParallelMinds Technology Solution Pvt.Ltd. All rights reserved.
 */

#import "PMUtility.h"

#pragma mark -
#pragma mark Constants
#pragma mark -
//**************************************************
//  Constants
//**************************************************


#pragma mark -
#pragma mark Private Interface
#pragma mark -
//**************************************************
//	Private Interface
//**************************************************

@interface PMUtility()

- (void) privateMethodA;

@end

#pragma mark -
#pragma mark Public Interface
#pragma mark -
//**************************************************
//	Public Interface
//**************************************************

@implementation PMUtility

#pragma mark -
#pragma mark Properties
//**************************************************
//  Properties
//**************************************************

@synthesize propertyIntA;

#pragma mark -
#pragma mark Constructors
//**************************************************
//  Constructors
//**************************************************

- (id)init
{
	if ((self = [super init]))
	{
		// Initialization code here.
	}
	
	return self;
}

#pragma mark -
#pragma mark Private Methods
//**********************************************************************************************************
//
//  Private Methods
//
//**********************************************************************************************************



#pragma mark -
#pragma mark Self Public Methods
//**********************************************************************************************************
//
//  Self Public Methods
//
//**********************************************************************************************************

+ (UIImageView*)createCircularImage:(UIImageView*)imageView{
    
    imageView.layer.cornerRadius = imageView.frame.size.width / 2;
    imageView.layer.borderWidth = 3.0f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.clipsToBounds = YES;
    return imageView;
}
+ (UIImageView*)createRoundedCornerImage:(UIImageView*)imageView{
    
    imageView.layer.cornerRadius = 10.0f;
    imageView.layer.borderWidth = 3.0f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.clipsToBounds = YES;
    
    
    return imageView;
}
+ (UIImageView*)createCircularImage:(UIImageView*)imageView borderColor:(CGColorRef )color{
    
    imageView.layer.cornerRadius = imageView.frame.size.width / 2;
    imageView.layer.borderWidth = 3.0f;
    imageView.layer.borderColor = color;//[UIColor whiteColor].CGColor;
    imageView.clipsToBounds = YES;
    return imageView;
}
+ (UIImageView*)createRoundedCornerImage:(UIImageView*)imageView borderColor:(CGColorRef )color{
    
    imageView.layer.cornerRadius = 10.0f;
    imageView.layer.borderWidth = 3.0f;
    imageView.layer.borderColor = color;
    imageView.clipsToBounds = YES;
    return imageView;
}

+ (void)showAlertWithTitle:(NSString*)title Message:(NSString*)message CancelButtonTitle:(NSString*)cancelButtonTitle
{
    
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
    [alertView show ];
}
/**
 *  Show an Action Sheet to display the options with tile and message and in the form of buttons
 *
 *  @param view                   Parent view on which Action Sheet needs to be displayed
 *  @param sender                 sender controller in which delegate needs to be implemented
 *  @param title                  title for Action Sheet
 *  @param message                description for Action Sheet
 *  @param cancelButtonTitle      Cancel button title
 *  @param destructiveButtonTitle Desctructive button title
 *  @param otherButtonTitle       Any Other Button Title
 */

+ (void)showActionSheetInAView:(UIView*)view fromSender:(id)sender withTitle:(NSString *)title Message:(NSString *)message CancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitle withTag:(int)actionSheetTag
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:sender cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitle,nil];
    actionSheet.tag = actionSheetTag;
    [actionSheet showInView:view];
}
/**
 *  Create PDF file with specified file name from supplied string
 *
 *  @param resultantString        pdf content
 *  @param pdfFileName            pdf file name  e.g. test.pdf
 */
+(NSData *)createPdf:(NSString *)resultantString pdfFileName:(NSString *)pdfFileName
{
    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // define path for pdf file
    NSString *documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:pdfFileName];
    
    //prepare text using core text framesetter
    CFAttributedStringRef currentText  = CFAttributedStringCreate(NULL,(__bridge CFStringRef)(resultantString), NULL);
    if(currentText)
    {
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
        if(framesetter)
        {
            // pdf context using default page size 612 x792
            UIGraphicsBeginPDFContextToFile(documentPath, CGRectZero, nil);
            CFRange currentRange = CFRangeMake(0, 0);
            NSInteger currentPage = 0;
            BOOL done = NO;
            do {
                // new page
                UIGraphicsBeginPDFPageWithInfo(CGRectMake(0,0, 612, 792),nil);
                //Draw page number at bottom of each page
                currentPage++;
                //[self drawPageNbr:currentPage];
                // update current pge to point to next page
                currentRange = *[self updatePDFPage:currentPage setTextRange:&currentRange setFramesetter:&framesetter];
                //if at end exit loop
                if(currentRange.location == CFAttributedStringGetLength((CFAttributedStringRef)currentText))
                    done = YES;
                
            } while (!done);
            
            //close pdf context
            UIGraphicsEndPDFContext();
            CFRelease(framesetter);
        }else
        {
            //NSLog(@"could not create frameset");
        }
        CFRelease(currentText);
    }
    else{
        //NSLog(@"current text could not be created");
    }
    NSString *filePath = [NSString stringWithFormat:@"%@",documentPath];
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    return myData;
}
/**
 *  Update PDF file
 */
+(CFRange*)updatePDFPage:(int)pageNumber setTextRange:(CFRange *)pageRange setFramesetter:(CTFramesetterRef *)framesetter
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    CGRect frameRect= CGRectMake(72,280, 668, 468);
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    CTFrameRef frameRef = CTFramesetterCreateFrame(*framesetter, *pageRange, framePath, NULL);
    CGPathRelease(framePath);
    CGContextTranslateCTM(currentContext, 0, 792);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // draw frame
    CTFrameDraw(frameRef, currentContext);
    *pageRange = CTFrameGetVisibleStringRange(frameRef);
    pageRange->location += pageRange->length;
    pageRange->length = 0;
    CFRelease(frameRef);
    return pageRange;
}
/**
 *  Responsible for enable or Disable flash light
 *
 *  @param on        boolean value
 */
+ (void)turnTorchOn:(bool)on {
    
    // check if flashlight available
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            
            if (on) {
                
                //NSLog(@"flashMode %d",[device flashMode]);
                
                if (([device flashMode] == AVCaptureTorchModeOn)) {
                    [device setTorchMode:AVCaptureTorchModeOff];
                    [device setFlashMode:AVCaptureFlashModeOff];
                }else if(([device flashMode] == AVCaptureTorchModeOff))
                {
                    [device setTorchMode:AVCaptureTorchModeOn];
                    [device setFlashMode:AVCaptureFlashModeOn];
                }
                
            } else {
                //NSLog(@"flashMode %d",[device flashMode]);
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                
                
            }
            [device unlockForConfiguration];
        }
        else  {
            [self showAlertWithTitle:@"Alert" Message:@"FlashMode is not available for this device" CancelButtonTitle:@"OK"];
            
        }
        
    }
}
/**
 *  Responsible for removing cache image for specified path
 *
 *  @param savedPath        string path value
 */
+ (void)removeImageFromImageCache:(NSString *)savedPath
{
    @try {
        // NSString *savedPath = [self filePathInDocDirectory:fileName];
        
        NSFileManager * fileManager = [NSFileManager defaultManager];
        NSError *error = nil;
        
        if([fileManager fileExistsAtPath:savedPath]) {
            [fileManager removeItemAtPath:savedPath error:&error];
            //NSLog(@"error = %@",[error description]);
        }
    }
    @catch (NSException *exception) {
        //NSLog(@"File removing Exception = %@",exception);
    }
    
}
//Json to string
+ (NSString *) jsonToString:(NSDictionary *) messageDictionary{
    
    NSError *error;
    NSString *jsonString;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:messageDictionary
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        //NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData
                                           encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

//String to JSON
+ (NSDictionary *) stringToJson: (NSString *) messageString{
    
    //Need a jSON dictionary here
    NSError* error;
    NSData * jsonData = [messageString dataUsingEncoding:NSUTF8StringEncoding
                                    allowLossyConversion:NO];
    
    NSDictionary* jsonDictionary = [NSJSONSerialization
                                    JSONObjectWithData:jsonData //1
                                    options:kNilOptions
                                    error:&error];
    return jsonDictionary;
}


//String to JSON
+ (NSDictionary *) jsonDataToDictionary: (NSData *) messageData{
    
    //Need a jSON dictionary here
    NSError* error;
    NSDictionary* jsonDictionary = [NSJSONSerialization
                                    JSONObjectWithData:messageData //1
                                    options:kNilOptions
                                    error:&error];
    return jsonDictionary;
}

/**
 * This method will return string after checking if there is a null value.
 * 1. If value is (null), it returns NA
 * 2. If value object is nil, it returns NA
 * 3. If value is not nil or (null) and if length is 0 for string, it will return
 *
 *  @param string input string to be checked for nil/(null) values
 *
 *  @return resultatnt string after checking nil/(null) values
 */

+ (NSString *)getStringAfterRemovingNullValuesForString:(NSString *)string
{
    NSString *resultantString = @"";
    
    if (string != nil && ![string isEqualToString:@"(null)"])
    {
        if ([string length] == 0)
            resultantString = @"NA";
        else
            resultantString = string;
    }
    else
    {
        resultantString = @"NA";
    }
    
    return resultantString;
}
#pragma mark -
#pragma mark Methods to Create of Dynamic Controls -

/**
 *  This method is used to add UIButton dynamically on sender view object.
 *
 *  @param view      A Parent View on which newly created UILabel needs to be added.
 *  @param frame     frame of UILabel to be placed on Parent View
 *  @param image         Image for Button's UIControlStateSelected
 *  @param selectedImage Image for Button's UIControlStateNormal
 *  @param target        target on which selector to be fired
 *  @param method        selector for specified target
 *  @param btnTag        tag for individual control
 *  @param btnType       Specify the UIBUttonType
 *  @param text          Title text on button
 *  @param bgColor       Background color for button
 */

+(void)addCustomViewToView:(UIView *)view
                customView:(UIView *)customView
                   WithTag:(NSInteger)viewTag
{
    @try {
        customView.tag = viewTag;
        [view addSubview:customView];
    }
    @catch (NSException *exception) {
        //NSLog(@"Excetion in addButtonToView: %@",exception.description);
    }
}


/**
 *  This method is used to add UIButton dynamically on sender view object.
 *
 *  @param view      A Parent View on which newly created UILabel needs to be added.
 *  @param frame     frame of UILabel to be placed on Parent View
 *  @param image         Image for Button's UIControlStateSelected
 *  @param selectedImage Image for Button's UIControlStateNormal
 *  @param target        target on which selector to be fired
 *  @param method        selector for specified target
 *  @param btnTag        tag for individual control
 *  @param btnType       Specify the UIBUttonType
 *  @param text          Title text on button
 *  @param bgColor       Background color for button
 */

+(void)addButtonToView:(UIView *)view withFrame:(CGRect)frame andImageForNormal:(UIImage *)image andForSelection:(UIImage *)selectedImage Target:(id)target Selector:(SEL)method WithTag:(NSInteger)btnTag andButtonType:(UIButtonType)btnType andTitle:(NSString *)text withBtnTitleColor:(UIColor *)bgColor withBtnBGColor:(UIColor*)backgroundColor
{
    
    @try {
        UIButton *button = [UIButton buttonWithType:btnType];
        button.frame = frame;
        button.tag = btnTag;
        
        [button setTitle:text forState:UIControlStateNormal];
        [button setTitleColor:bgColor forState:UIControlStateNormal];
        
        [button setBackgroundColor:backgroundColor];
        [button addTarget:target action:method forControlEvents:UIControlEventTouchUpInside];
        [button setImage:image forState:UIControlStateNormal];
        // RN CHANGE SELECTED IMAGE
        //[button setImage:selectedImage forState:UIControlStateHighlighted];
        [view addSubview:button];
    }
    @catch (NSException *exception) {
        //NSLog(@"Excetion in addButtonToView: %@",exception.description);
    }
}

/**
 *  This method is used to add UILabel dynamically on sender view object.
 *
 *  @param view      A Parent View on which newly created UILabel needs to be added.
 *  @param frame     frame of UILabel to be placed on Parent View
 *  @param string    Text to be assigned to UILabel
 *  @param textColor Color of Text
 *  @param bold      Text should be bold ot not
 *  @param tag       tag for individual control
 *  @param fontSize  font size
 */
+ (void) addLabelToView:(UIView *)view WithFrame:(CGRect)frame andText:(NSString *)string withTextColor:(UIColor*)textColor Bold:(BOOL)bold andTag:(NSInteger)tag withFontSize:(float)fontSize withNumberOfLines:(float)lines withBackgroundColor:(UIColor*)background
{
    @try {
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.numberOfLines = lines;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = string;
        label.textColor = textColor;
        label.tag = tag;
        label.baselineAdjustment = UIBaselineAdjustmentNone;
        if (bold) {
            label.font = [UIFont boldSystemFontOfSize:fontSize];
        }else {
            label.font = [UIFont systemFontOfSize:fontSize];
        }
        [view addSubview:label];
        label.backgroundColor = background;
    }
    @catch (NSException *exception) {
        //NSLog(@"Excetion in addLabelToView: %@",exception.description);
    }
}

/**
 *  This method is used to add UIImageView dynamically on sender view object.
 *
 *  @param view  A Parent View on which newly created UILabel needs to be added.
 *  @param frame frame of UILabel to be placed on Parent View
 *  @param image Image to be assigned
 *  @param tag   tag for individual control
 */

+ (void)addImageViewToView:(UIView *)view WithFrame:(CGRect)frame andImage:(UIImage *)image withTag:(NSInteger)tag
{
    
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    // Here we use the new provided setImageWithURL: method to load the web image
	[imageView setImage:image];
	imageView.tag = tag;
	[view addSubview:imageView];
}

#pragma mark -
#pragma mark View Customizations Methods -

/**
 *  Method is useful for view customization to make it circular. This method will work to when view width and height are same.
 *
 *  @param view    View to be customized
 *  @param color   border color which will be covering a circular view
 *  @param bgColor background color for view
 */

+ (void)makeViewWithRoundCorners:(UIView *)view withCornerRadius:(float)radius withBorderWidth:(float)width withBorderColor:(UIColor *)color andBGColor:(UIColor *)bgColor
{
    view.clipsToBounds = YES;
    view.layer.cornerRadius = radius;
    view.layer.borderColor= color.CGColor;
    view.layer.borderWidth=width;
    view.backgroundColor = bgColor;
}


/**
 *  This method will create a .png image covering a complete view passed as an argument to this method
 *
 *  @param view view for which .png needs to be created.
 *
 *  @return It will return an image for specified view.
 */

+ (UIImage *) takeScreenshotForView:(UIView *)view
{
    UIImage *image ;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else
    {
        NSLog(@"This method only supports iOS version >= 7.0");
    }
    
    return image;
}


@end

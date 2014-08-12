/*!
 *	PmTSLUtility.h
 *	Utility
 *	
 *	Created by B.P.SINGH on 26/06/14.
 *	Copyright 2014 ParallelMinds Technology Solution Pvt.Ltd. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface PMUtility : NSObject
{
@public
	int			_publicInt;
@protected
	int			_protectedInt;
@private
	int			_privateInt;
}

@property (nonatomic) int propertyIntA;
/**
 *  Creates circular image view
 *
 *  @param imageView UIImageView object to be modified as circle view
 *
 *  @return UIImageView with circular property
 */
+ (UIImageView*)createCircularImage:(UIImageView*)imageView;
/**
 *  Creates round corner image view
 *
 *  @param imageView  UIImageView object to be modified as round corner view
 *
 *  @return UIImageView with round cor property
 */

+ (UIImageView*)createRoundedCornerImage:(UIImageView*)imageView;
/**
 *  Creates circular image with specified border color
 *
 *  @param imageView UIImageView object to be modified as circular view with border color
 *  @param color     specific border color
 *
 *  @return UIImageView with circular and with border color specified.
 */
+ (UIImageView*)createCircularImage:(UIImageView*)imageView borderColor:(CGColorRef )color;
/**
 *  Creates round corner image view
 *
 *  @param imageView UIImageView object to be modified as round corner with background
 *  @param color     specific border color
 *
 *  @return UIImageView with rounded and border color specified.
 */
+ (UIImageView*)createRoundedCornerImage:(UIImageView*)imageView borderColor:(CGColorRef )color;

/**
 *  Responsible for showing UIAlertView
 *
 *  @param title             alertview title
 *  @param bodyText          alert messege
 *  @param cancelButtonTitle cancel or Dismiss button title
 */
+ (void)showAlertWithTitle:(NSString*)title Message:(NSString*)message CancelButtonTitle:(NSString*)cancelButtonTitle;

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

+ (void)showActionSheetInAView:(UIView*)view fromSender:(id)sender withTitle:(NSString *)title Message:(NSString *)message CancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitle withTag:(int)actionSheetTag;

/**
 *  Create PDF file with specified file name from supplied string
 *
 *  @param resultantString        pdf content
 *  @param pdfFileName            pdf file name  e.g. test.pdf
 */
-(NSData *)createPdf:(NSString *)resultantString pdfFileName:(NSString *)pdfFileName;

/**
 *  Update PDF file
 */
-(CFRange*)updatePDFPage:(int)pageNumber setTextRange:(CFRange *)pageRange setFramesetter:(CTFramesetterRef *)framesetter;


/**
 *  Responsible for enable or Disable flash light
 *
 *  @param on        boolean value
 */
+ (void)turnTorchOn:(bool)on;

/**
 *  Responsible for removing cache image for specified path
 *
 *  @param savedPath        string path value
 */
+ (void)removeImageFromImageCache:(NSString *)savedPath;
/**
 *  Json to string
 *
 *  @param messageDictionary        NSDictionary data to be converted into json String
 */
+ (NSString *) jsonToString:(NSDictionary *) messageDictionary;

/**
 *  String to JSON
 *
 *  @param messageString        NSString data to be converted into NSDictionary
 */
+ (NSDictionary *) stringToJson: (NSString *) messageString;

/**
 * JSON Data to Dictionary
 *
 *  @param messageString        NSData data to be converted into NSDictionary
 */
+ (NSDictionary *) jsonDataToDictionary: (NSData *) messageData;

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

+ (NSString *)getStringAfterRemovingNullValuesForString:(NSString *)string;

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
+ (void)addCustomViewToView:(UIView *)view
                customView:(UIView *)customView
                   WithTag:(NSInteger)viewTag;

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
+(void)addButtonToView:(UIView *)view withFrame:(CGRect)frame andImageForNormal:(UIImage *)image andForSelection:(UIImage *)selectedImage Target:(id)target Selector:(SEL)method WithTag:(NSInteger)btnTag andButtonType:(UIButtonType)btnType andTitle:(NSString *)text withBtnTitleColor:(UIColor *)bgColor withBtnBGColor:(UIColor*)backgroundColor;
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
+ (void) addLabelToView:(UIView *)view WithFrame:(CGRect)frame andText:(NSString *)string withTextColor:(UIColor*)textColor Bold:(BOOL)bold andTag:(NSInteger)tag withFontSize:(float)fontSize withNumberOfLines:(float)lines withBackgroundColor:(UIColor*)background;
/**
 *  This method is used to add UIImageView dynamically on sender view object.
 *
 *  @param view  A Parent View on which newly created UILabel needs to be added.
 *  @param frame frame of UILabel to be placed on Parent View
 *  @param image Image to be assigned
 *  @param tag   tag for individual control
 */

+ (void)addImageViewToView:(UIView *)view WithFrame:(CGRect)frame andImage:(UIImage *)image withTag:(NSInteger)tag;

/**
 *  Method is useful for view customization to make it circular. This method will work to when view width and height are same.
 *
 *  @param view    View to be customized
 *  @param color   border color which will be covering a circular view
 *  @param bgColor background color for view
 */

+ (void)makeViewWithRoundCorners:(UIView *)view withCornerRadius:(float)radius withBorderWidth:(float)width withBorderColor:(UIColor *)color andBGColor:(UIColor *)bgColor;
/**
 *  This method will create a .png image covering a complete view passed as an argument to this method
 *
 *  @param view view for which .png needs to be created.
 *
 *  @return It will return an image for specified view.
 */

+ (UIImage *) takeScreenshotForView:(UIView *)view;
@end

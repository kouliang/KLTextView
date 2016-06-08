//
//  KLTextView.h
//
//  Created by kouliang on 16/6/8.
//  Copyright © 2016年 kouliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KLTextView;

@protocol KLTextViewDelegate <NSObject>
@optional
- (BOOL)textViewShouldBeginEditing:(KLTextView *)textView;
- (BOOL)textViewShouldEndEditing:(KLTextView *)textView;
- (BOOL)textView:(KLTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (BOOL)textView:(KLTextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0);
- (BOOL)textView:(KLTextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0);

- (void)textViewDidBeginEditing:(KLTextView *)textView;
- (void)textViewDidEndEditing:(KLTextView *)textView;
- (void)textViewDidChange:(KLTextView *)textView;
- (void)textViewDidChangeSelection:(KLTextView *)textView;
@end

@interface KLTextView : UIView
@property(nonatomic,weak)    NSString        *text;
@property(nonatomic,weak)    UIFont          *font;
@property(nonatomic,weak)    UIColor         *textColor;
@property(nonatomic,assign)  NSTextAlignment textAlignment;
@property(nonatomic,assign)  UIEdgeInsets    textContainerInset;
@property(nonatomic,weak)    id<KLTextViewDelegate> delegate;

/** 限制的数量，默认为LONG_MAX不显示 */
@property(nonatomic,assign)  NSInteger       limitNum;
@property(nonatomic,copy)    NSString        *placeholder;
@end




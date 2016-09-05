//
//  KLTextView.m
//
//  Created by kouliang on 16/6/8.
//  Copyright © 2016年 kouliang. All rights reserved.
//

#import "KLTextView.h"

@interface KLTextView ()<UITextViewDelegate>
@property(nonatomic,weak)UITextView *textView;
@property(nonatomic,weak)UILabel *placeholderLabel;
@property(nonatomic,weak)UILabel *limitNumLabel;
@end

@implementation KLTextView
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self initProperties];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self initProperties];
    }
    return self;
}
- (void)initProperties {
    UITextView *textView = [[UITextView alloc]init];
    textView.delegate = self;
    [self addSubview:textView];
    _textView = textView;
    
    UILabel *placeholderLabel = [[UILabel alloc]init];
    placeholderLabel.textAlignment = NSTextAlignmentLeft;
    placeholderLabel.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [self addSubview:placeholderLabel];
    _placeholderLabel = placeholderLabel;
    
    UILabel *limitNumLabel = [[UILabel alloc]init];
    limitNumLabel.textAlignment = NSTextAlignmentRight;
    limitNumLabel.font = [UIFont systemFontOfSize:14.0f];
    limitNumLabel.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [self addSubview:limitNumLabel];
    _limitNumLabel = limitNumLabel;
    
    _limitNum = LONG_MAX;
    _limitNumLabel.hidden = YES;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _textView.frame = self.bounds;
    _textView.backgroundColor = self.backgroundColor;
    _limitNumLabel.frame = CGRectMake(self.bounds.size.width-150-6, self.bounds.size.height-15-6, 150, 15);
    
    UIFont *font = _textView.font;
    if (font==nil) {
        font = [UIFont systemFontOfSize:14];
    }
    UIEdgeInsets edgeInset = _textView.textContainerInset;
    CGFloat height = font.lineHeight;
    _placeholderLabel.textAlignment = _textView.textAlignment;
    _placeholderLabel.font = font;
    _placeholderLabel.frame = CGRectMake(edgeInset.left+5, edgeInset.top, self.bounds.size.width-(edgeInset.left+5)-(edgeInset.right+5), height);
}
#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([_delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [_delegate textViewShouldBeginEditing:self];
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([_delegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [_delegate textViewShouldEndEditing:self];
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSMutableString *newtext = [NSMutableString stringWithString:textView.text];
    [newtext replaceCharactersInRange:range withString:text];
    BOOL result = ([newtext length]<=_limitNum);
    
    if ([_delegate respondsToSelector:@selector(textView: shouldChangeTextInRange:replacementText:)]) {
        BOOL delegateResult = [_delegate textView:self shouldChangeTextInRange:range replacementText:text];
        return result&&delegateResult;
    }
    return result;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    if ([_delegate respondsToSelector:@selector(textView: shouldInteractWithURL:inRange:)]) {
        return [_delegate textView:self shouldInteractWithURL:URL inRange:characterRange];
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
    if ([_delegate respondsToSelector:@selector(textView: shouldInteractWithTextAttachment:inRange:)]) {
        return [_delegate textView:self shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([_delegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [_delegate textViewDidBeginEditing:self];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([_delegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [_delegate textViewDidEndEditing:self];
    }
}
- (void)textViewDidChange:(UITextView *)textView{
    if(textView.text.length > 0) {
        _placeholderLabel.hidden = YES;
    }else {
        _placeholderLabel.hidden = NO;
    }
    
    
    NSString *str = textView.text;
    NSInteger number = [str length];
    if ((number > _limitNum)&&(textView.markedTextRange == nil)) { //兼容iOS7
        textView.text = [str substringToIndex:NSMaxRange([str rangeOfComposedCharacterSequenceAtIndex:_limitNum-1])];
    }
    _limitNumLabel.text = [NSString stringWithFormat:@"%zd", _limitNum - _textView.text.length];
    
    if ([_delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [_delegate textViewDidChange:self];
    }
}
- (void)textViewDidChangeSelection:(UITextView *)textView{
    if ([_delegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [_delegate textViewDidChangeSelection:self];
    }
}

#pragma mark - textViewProperties
- (void)setText:(NSString *)text{
    _textView.text = text;
    [self textViewDidChange:_textView];
}
- (NSString *)text{
    return _textView.text;
}
- (void)setFont:(UIFont *)font{
    _textView.font = font;
}
- (UIFont *)font{
    return _textView.font;
}
- (void)setTextColor:(UIColor *)textColor{
    _textView.textColor = textColor;
}
- (UIColor *)textColor{
    return _textView.textColor;
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    _textView.textAlignment = textAlignment;
}
- (NSTextAlignment)textAlignment{
    return _textView.textAlignment;
}
- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset{
    _textView.textContainerInset = textContainerInset;
}
- (UIEdgeInsets)textContainerInset{
    return _textView.textContainerInset;
}
- (void)setLimitNum:(NSInteger)limitNum{
    _limitNum = limitNum;
    if (limitNum == LONG_MAX) {
        _limitNumLabel.hidden = YES;
    }else{
        _limitNumLabel.text = [NSString stringWithFormat:@"%ld",limitNum];
        _limitNumLabel.hidden = NO;
    }
}
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _placeholderLabel.text = placeholder;
}
@end

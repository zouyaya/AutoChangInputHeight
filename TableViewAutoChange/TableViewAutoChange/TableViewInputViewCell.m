//
//  TableViewInputViewCell.m
//  TableViewAutoChange
//
//  Created by yangou on 2020/4/10.
//  Copyright © 2020 hello. All rights reserved.
//

#import "TableViewInputViewCell.h"


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define k_ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface TableViewInputViewCell ()

@property (strong, nonatomic) UIView *bottomView;

@property (strong, nonatomic) UITextView *infoTextView;

@property (strong, nonatomic) UILabel *placeholderLabel;

@end


@implementation TableViewInputViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"TableViewInputViewCell";
    TableViewInputViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[TableViewInputViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return cell;
    
    
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self configerTheSubviewUI];
        
    }
    
    return self;
    
    
}

-(void)configerTheSubviewUI
{

    //此处是我自己实现demo的布局，其他的布局可以自己实现，不影响输入的内容
    
    self.backgroundColor = UIColorFromRGB(0xfafafa);
    
   _bottomView = [[UIView alloc]init];
   _bottomView.backgroundColor = UIColorFromRGB(0xfafafa);
   _bottomView.frame = CGRectMake(0, 0, k_ScreenWidth, 70);
   [self.contentView addSubview:_bottomView];

    
    
   _infoTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, 10, k_ScreenWidth - 30, 70)];
   _infoTextView.delegate = self;
   _infoTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
   _infoTextView.font = [UIFont systemFontOfSize:16];
   _infoTextView.scrollEnabled = NO;
   _infoTextView.showsVerticalScrollIndicator = NO;
   _infoTextView.showsHorizontalScrollIndicator = NO;
   _infoTextView.returnKeyType = UIReturnKeyDone;
   _infoTextView.keyboardType = UIKeyboardTypeDefault;
    _infoTextView.inputAccessoryView = [[UIToolbar alloc]initWithFrame:CGRectZero];
   _infoTextView.backgroundColor = [UIColor clearColor];
    [self.bottomView addSubview:_infoTextView];
    
    

    _placeholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 80, 44)];
    _placeholderLabel.text = @"请输入内容";
    _placeholderLabel.textColor = UIColorFromRGB(0x999999);
    _placeholderLabel.font=[UIFont systemFontOfSize:16];
    [_infoTextView addSubview:_placeholderLabel];
    
    
}

- (void)dismissButtonAction {
   
    [_infoTextView resignFirstResponder];
}
- (void)setContentStr:(NSString *)contentStr {
   
    _contentStr = contentStr;
    _infoTextView.text = _contentStr;
    _placeholderLabel.hidden = _contentStr.length ? YES : NO;
    
    //如果是根据内容计算高度
   // [self updateTheTextHeight];
    
}
- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}
- (void)setPlaceholder:(NSString *)placeholder {
    
    _placeholder = placeholder;
    _placeholderLabel.text = _placeholder;
}



- (CGFloat)CellHeight {
    
    CGSize size = [_infoTextView sizeThatFits:CGSizeMake(_infoTextView.frame.size.width, MAXFLOAT)];
    if (size.height < 50) {
        
        return 70;
    }else{
        
        return size.height + 20;
    }

}

-(void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length==0) {
        
        _placeholderLabel.hidden=NO;
        
    } else {
        
        _placeholderLabel.hidden=YES;
        //限定输入1000字
//        if (textView.text.length > 1000) {
//
//            textView.text = [textView.text substringToIndex:1000];
//        }
        
    }
    [self updateTheTextHeight];
}



-(void)updateTheTextHeight
{
    if ([self.delegate respondsToSelector:@selector(updatedText:atIndexPath:)]) {
           [self.delegate updatedText:_infoTextView.text atIndexPath:_indexPath];
       }
       
       CGRect frame = _infoTextView.frame;
       CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
       CGSize size = [_infoTextView sizeThatFits:constraintSize];
       _bottomView.frame = CGRectMake(0, 0, k_ScreenWidth, self.contentView.frame.size.height);
       _infoTextView.frame = CGRectMake(15, 10, k_ScreenWidth - 30, _bottomView.frame.size.height - 20);
     
    [_tableView beginUpdates];
    [_tableView endUpdates];
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

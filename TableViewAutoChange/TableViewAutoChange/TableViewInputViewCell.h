//
//  TableViewInputViewCell.h
//  TableViewAutoChange
//
//  Created by yangou on 2020/4/10.
//  Copyright © 2020 hello. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TableViewInputViewCellDelegate <NSObject>

@required
- (void)updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath;

@end

@interface TableViewInputViewCell : UITableViewCell <UITextViewDelegate>


@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSIndexPath * indexPath;

@property (nonatomic,strong) NSString * contentStr;

@property (nonatomic,strong) NSString * placeholder;

- (CGFloat)CellHeight;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,assign)id<TableViewInputViewCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END

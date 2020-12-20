

#import <UIKit/UIKit.h>

@interface UITableView (YYAdd)

- (void)updateWithBlock:(void (^)(UITableView *tableView))block;

/**
 *  滚动到某一行
 *
 *  @param row row
 *  @param section section
 *  @param scrollPosition scrollPosition
 *  @param animated animated
 */
- (void)scrollToRow:(NSUInteger)row inSection:(NSUInteger)section atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;

/**
 *  插入一行
 *
 *  @param row row
 *  @param section section
 *  @param animation animation
 */
- (void)insertRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  重新加载某一行
 *
 *  @param row row
 *  @param section section
 *  @param animation animation
 */
- (void)reloadRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  删除某一行
 *
 *  @param row row
 *  @param section section
 *  @param animation animation
 */
- (void)deleteRow:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  在指定位置插入一行
 *
 *  @param indexPath indexPath
 *  @param animation animation
 */
- (void)insertRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  重新加载某一行
 *
 *  @param indexPath indexPath
 *  @param animation animation
 */
- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  删除某一行
 *
 *  @param indexPath indexPath
 *  @param animation animation
 */
- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  插入section
 *
 *  @param section section
 *  @param animation animation
 */
- (void)insertSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  删除section
 *
 *  @param section section
 *  @param animation animation
 */
- (void)deleteSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  重新加载section
 *
 *  @param section section
 *  @param animation animation
 */
- (void)reloadSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

/**
 *  删除选中的行
 *
 *  @param animated 是否动画
 */
- (void)clearSelectedRowsAnimated:(BOOL)animated;

@end


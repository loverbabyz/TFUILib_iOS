//
//  TFTreeNode.h
//  TFUILib
//
//  Created by Daniel.Sun on 2018/1/27.
//

#import "TFModel.h"

#pragma mark -
#pragma mark - TFTreeNode
@protocol TFTreeNode <NSObject>
@end

@interface TFTreeNode : TFModel

/**
 根id
 */
@property (nonatomic, assign) NSInteger rootIdentity;

/**
 子节点
 */
@property (nonatomic, strong) NSArray<TFTreeNode *> *nodes;

@end

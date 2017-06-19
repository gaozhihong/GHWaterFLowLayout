//
//  GHFlowLayout.m
//  GHWaterFlowLayout
//
//  Created by gaozhihong on 2017/6/19.
//  Copyright © 2017年 gaozhihong. All rights reserved.
//

#import "GHFlowLayout.h"
 // 默认列数
#define GHDefaultColumsCount 3
 /** 默认的行间距 */
#define GHDefaultColumMargin 10

static const UIEdgeInsets GHDefaultInsets = {10,10,10,10};


@interface GHFlowLayout()

/** 每一列的最大y值 */
@property(nonatomic,strong)NSMutableArray*columMaxYArray;
 /** 所有cell的属性数组  */
@property(nonatomic,strong)NSMutableArray*attrsArray;



@end
@implementation GHFlowLayout
-(NSMutableArray *)columMaxYArray{
    if (_columMaxYArray == nil) {
        _columMaxYArray = [NSMutableArray array];
    }
    return _columMaxYArray;
}
-(NSMutableArray *)attrsArray{
    if (_attrsArray == nil) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

#pragma mark  -- 实现内部方法 
-(CGSize)collectionViewContentSize{
   
    CGFloat destMaxY = [self.columMaxYArray[0] floatValue];
    for (int  i = 0; i < self.columMaxYArray.count; i++) {
        CGFloat columsMaxY = [self.columMaxYArray[i] floatValue];
        if (destMaxY < columsMaxY) {
            destMaxY = columsMaxY;
        }
    }
    return CGSizeMake(0, destMaxY+GHDefaultInsets.bottom);
    
    
    
}

 /** 每一刷新会调用此方法 */
-(void)prepareLayout{
    [super prepareLayout];
     // 清楚数据
    [self.columMaxYArray removeAllObjects];
    for ( int i = 0; i < GHDefaultColumsCount; i++) {
        [self.columMaxYArray addObject:@(GHDefaultInsets.top)];
    }
    
     // 充值cell的所有的属性
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i  = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes*attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attribute];
        
    }
    
}
/** 多有元素的恩布局属性数组*/
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
    
}

-(UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes*attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
       // 水平的总间距
    CGFloat xMargin = GHDefaultInsets.left+GHDefaultInsets.right+(GHDefaultColumsCount-1)*GHDefaultColumMargin;
    CGFloat collectionW = self.collectionView.bounds.size.width;
    
     // 每一个cell的宽度
    CGFloat itemW = (collectionW -xMargin)/GHDefaultColumsCount;
     // cell 高度 测试数据 随机给一个高度
    CGFloat itemH = 100+arc4random_uniform(50);
    
      // 找到最短的的那一列 - 遍历所有的元素
    NSInteger destColum = 0;
    CGFloat destMaxY = [self.columMaxYArray[0] floatValue];
    for (int i = 0; i < self.columMaxYArray.count ; i++) {
        CGFloat columMaxY = [self.columMaxYArray[i] floatValue] ;
        if (destMaxY > columMaxY) {
            destMaxY = columMaxY;
            destColum = i;
        }
    }
    
     // cell  x 和y值
    CGFloat x = GHDefaultInsets.left +destColum*(itemW+GHDefaultColumMargin);
    CGFloat y = GHDefaultInsets.top +destMaxY;
    attrs.frame = CGRectMake(x, y, itemW, itemH);
    self.columMaxYArray[destColum] = @(CGRectGetMaxY(attrs.frame));
    
    
    
    return attrs;
    
}


@end

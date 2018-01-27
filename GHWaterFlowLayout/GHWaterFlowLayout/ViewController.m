//
//  ViewController.m
//  GHWaterFlowLayout
//
//  Created by gaozhihong on 2017/6/19.
//  Copyright © 2017年 gaozhihong. All rights reserved.
//

#import "ViewController.h"
#import "GHFlowLayout.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>


@end
NSString *cellId = @"cellId";

@implementation ViewController{
    UICollectionView*_collectionView;
    
}

- (void)viewDidLoad {
    // Do any additional setup after loading the view, typically
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupCollectionView];
//
}
-(void)setupCollectionView{
    
    GHFlowLayout * flowLayout = [[GHFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    _collectionView.delegate  =self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled = YES;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)  collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = indexPath.item % 2 == 0 ? [UIColor yellowColor] : [UIColor blueColor];
    
    return cell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

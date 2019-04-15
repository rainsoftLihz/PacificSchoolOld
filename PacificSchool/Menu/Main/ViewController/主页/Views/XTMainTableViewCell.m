//
//  XTMainTableViewCell.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/7.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTMainTableViewCell.h"
#import "XTMyCourseCollectionViewCell.h"

@interface XTMainTableViewCell()
<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
>

@property (nonatomic,strong)NSArray *models;

@end
@implementation XTMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initData];
    [self initView];
}

- (void)initData {
    
}

- (void)initView {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
   
    float width = kScreenW/2.5;

    [layout setItemSize:CGSizeMake(width, 110)];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 110) collectionViewLayout:layout];
    
    self.collectionView.dataSource  = self;
    self.collectionView.delegate = self;
    // self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XTMyCourseCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.models.count>3) {
        return 3;
    }
    return self.models.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XTMyCourseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell loadModel:self.models[indexPath.row]];
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(selelctedCourseWithIndex:model:)]) {
        [self.delegate selelctedCourseWithIndex:self model:self.models[indexPath.row]];
    }
}

- (void)loadModels:(NSArray *)models {
    _models = models;
    [self.collectionView reloadData];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

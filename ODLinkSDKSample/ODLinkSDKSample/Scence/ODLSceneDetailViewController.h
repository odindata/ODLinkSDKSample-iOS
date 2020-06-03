//
//  ODLSceneDetailViewController.h
//  ODLinkSDKSample
//
//  Created by nathan on 2020/5/20.
//  Copyright © 2020 odin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ODLSceneDetailViewController : UIViewController
@property (strong, nonatomic) NSDictionary *currentDict;
@property(nonatomic,assign) NSInteger pageId;
@end

NS_ASSUME_NONNULL_END

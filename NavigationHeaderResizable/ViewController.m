//
//  ViewController.m
//  NavigationHeaderResizable
//
//  Created by Bemobile on 6/10/15.
//  Copyright © 2015 ianmagarzo. All rights reserved.
//

#import "ViewController.h"
#import "StyleConstants.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UILabel *labelNavTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelNavTitleComprimed;
@property (weak, nonatomic) IBOutlet UIView *viewSeparator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ctNavigationHeight;


@property (weak, nonatomic) IBOutlet UIScrollView *canvasScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ctCanvasScrollTop;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadStyles];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Styles

- (void)loadStyles{
    _ctCanvasScrollTop.constant = 0;
    _canvasScrollView.contentInset = UIEdgeInsetsMake(kNavigationHeaderMaxHeight-20, 0, 0, 0);
    _viewSeparator.alpha = 0;
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contentOffsetWithOutInset = _canvasScrollView.contentOffset.y+_canvasScrollView.contentInset.top;
    if ((kNavigationHeaderMaxHeight - contentOffsetWithOutInset) > kNavigationHeaderMinHeight && (kNavigationHeaderMaxHeight - contentOffsetWithOutInset < kNavigationHeaderMaxHeight)) {
        
        _ctNavigationHeight.constant =(kNavigationHeaderMaxHeight - contentOffsetWithOutInset);
    }else if (_canvasScrollView.contentSize.height < (_canvasScrollView.frame.size.height + _canvasScrollView.contentOffset.y)) { //Disable Bottom Bounce
        _canvasScrollView.contentOffset = CGPointMake(0.0, _canvasScrollView.contentSize.height - _canvasScrollView.frame.size.height);
    }
    _ctNavigationHeight.constant = (kNavigationHeaderMaxHeight - contentOffsetWithOutInset > kNavigationHeaderMaxHeight) ? kNavigationHeaderMaxHeight : _ctNavigationHeight.constant;
    _ctNavigationHeight.constant = (kNavigationHeaderMaxHeight - contentOffsetWithOutInset < kNavigationHeaderMinHeight) ? kNavigationHeaderMinHeight : _ctNavigationHeight.constant;
    
    CGFloat maxOffset = kNavigationHeaderMaxHeight - kNavigationHeaderMinHeight;
    
    [_navigationView layoutIfNeeded];
    
    CGFloat alphaBig =  (maxOffset - (kNavigationHeaderMaxHeight - _navigationView.frame.size.height ) ) / maxOffset;
    
    CGFloat alphaSmall = 1 - alphaBig;
    
    _labelNavTitle.alpha = alphaBig;
    _labelNavTitleComprimed.alpha = alphaSmall;
    _viewSeparator.alpha = alphaSmall;
}

@end

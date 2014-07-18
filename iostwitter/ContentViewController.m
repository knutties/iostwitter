//
//  ContentViewController.m
//  iostwitter
//
//  Created by Natarajan Kannan on 7/16/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import "ContentViewController.h"

#define SLIDE_TIMING .25
#define PANEL_WIDTH 60
#define CENTER_TAG 1
#define LEFT_TAG 2

@interface ContentViewController ()

@property (nonatomic, strong) UINavigationController* homeLineNavController;
@property (nonatomic, strong) MenuViewController* menuViewController;
@property (nonatomic, strong) TweetsViewController* tweetsViewController;
@property (nonatomic, assign) BOOL showPanel;
@property (nonatomic, assign) CGPoint preVelocity;

@end

@implementation ContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupViewControllers:@"home" ];
    
}

- (void) setupViewControllers:(NSString *) name {
    self.tweetsViewController = nil;
    self.homeLineNavController = nil;
    
    self.tweetsViewController = [[TweetsViewController alloc] initWithName:name];
    
    self.homeLineNavController = [[UINavigationController alloc] initWithRootViewController:_tweetsViewController];
    
    [self addChildViewController:_homeLineNavController];
    _homeLineNavController.view.tag = CENTER_TAG;
    _tweetsViewController.delegate = self;
    _homeLineNavController.view.frame = self.view.frame;
    [self.view addSubview:_homeLineNavController.view];
    [_homeLineNavController didMoveToParentViewController:self];
    
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    [_homeLineNavController.view addGestureRecognizer:panRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *) getLeftView {
    if (_menuViewController == nil)
    {
        // this is where you define the view for the left panel
        self.menuViewController = [[MenuViewController alloc] init];
        self.menuViewController.view.tag = LEFT_TAG;
        self.menuViewController.delegate = self;
        
        [self.view addSubview:self.menuViewController.view];
        
        [self addChildViewController:_menuViewController];
        [_menuViewController didMoveToParentViewController:self];
        
        _menuViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    self.showingLeftPanel = YES;
    
    UIView *view = self.menuViewController.view;
    return view;
}

-(void)movePanel:(id)sender
{
    
    [[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        UIView *childView = nil;
        
        if(velocity.x > 0) {
                childView = [self getLeftView];
        }
    
        // Make sure the view you're working with is front and center.
        [self.view sendSubviewToBack:childView];
        [[sender view] bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        if(velocity.x > 0) {
            // NSLog(@"gesture went right");
        } else {
            // NSLog(@"gesture went left");
        }
        
        if (!_showPanel) {
            [self movePanelToOriginalPosition];
        } else {
            if (_showingLeftPanel) {
                [self movePanelRight];
            }
        }
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        if(velocity.x > 0) {
            // NSLog(@"gesture went right");
        } else {
            // NSLog(@"gesture went left");
        }
        
        // Are you more than halfway? If so, show the panel when done dragging by setting this value to YES (1).
        _showPanel = abs([sender view].center.x - _homeLineNavController.view.frame.size.width/2) > _homeLineNavController.view.frame.size.width/2;
        
        // Allow dragging only in x-coordinates by only updating the x-coordinate with translation position.
        [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
        [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];
        
        // If you needed to check for a change in direction, you could use this code to do so.
        if(velocity.x*_preVelocity.x + velocity.y*_preVelocity.y > 0) {
            // NSLog(@"same direction");
        } else {
            // NSLog(@"opposite direction");
        }
        
        _preVelocity = velocity;
    }
    
}


-(void) resetMainView {
    [self.menuViewController.view removeFromSuperview];
	self.menuViewController = nil;
    
	self.showingLeftPanel = NO;
}

- (void)movePanelToOriginalPosition
{
    
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _homeLineNavController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             [self resetMainView];
                         }
                     }];
}

- (void) movePanelRight {
    UIView *childView = [self getLeftView];
    [self.view sendSubviewToBack:childView];
    
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _homeLineNavController.view.frame = CGRectMake(self.view.frame.size.width - PANEL_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    

    
}

- (void) resetTweetsViewController:(NSString *)name {
    [self setupViewControllers:name];
}

@end

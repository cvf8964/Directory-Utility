//
//  GBDragAndDropView.h
//  GBDragAndDropView
//
//  Created by Andrew A.A. on 26/09/12.
//  Copyright (c) 2012 Andrew A.A. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	GBFocusedViewStyle = 1,
	GBUnfocusedViewStyle = 0
} GBDragAndDropViewStyle;

@class GBDragAndDropView;
@protocol GBDragAndDropViewDelegate;


@protocol GBDragAndDropViewDelegate <NSObject>
@required
- (void)dragAndDropView:(GBDragAndDropView *)view didReceiveDroppedSource:(NSString *)source shouldUseFileData:(BOOL)shouldUseFileData;
@end


@interface GBDragAndDropView : NSImageView <NSDraggingDestination>

@property (nonatomic, strong) NSImage *background;
@property (nonatomic, strong) NSArray *supportedFileTypes;
@property (nonatomic, retain) IBOutlet id<GBDragAndDropViewDelegate> delegate;


@end



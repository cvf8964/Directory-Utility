//
//  GBDragAndDropView.m
//  GBDragAndDropView
//
//  Created by Andrew A.A. on 26/09/12.
//  Copyright (c) 2012 Andrew A.A. All rights reserved.
//

#import "GBDragAndDropView.h"

#define ACCEPT_FOLDER

@interface GBDragAndDropView ()

@property (nonatomic, assign) GBDragAndDropViewStyle viewStyle;
@property (nonatomic, assign) BOOL shouldUseFileData;

@end


@implementation GBDragAndDropView

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
		[self registerForDraggedTypes:@[NSFilenamesPboardType]];
		self.supportedFileTypes = [[NSArray alloc] initWithObjects:@"icns", @"png", @"tiff", @"tif", @"jpg", @"jpeg", nil];

    }
    return self;
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
	@autoreleasepool {

		NSArray *draggedFiles = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
		NSString *lastFilePath = draggedFiles.lastObject;

		NSFileManager *fileManager = [NSFileManager defaultManager];
		BOOL isDirectory = NO;

		[fileManager fileExistsAtPath:lastFilePath isDirectory:&isDirectory];

		if ([self.supportedFileTypes containsObject:lastFilePath.pathExtension])
			self.shouldUseFileData = YES;
		else
			self.shouldUseFileData = NO;

		return NSDragOperationCopy;
	}
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
	@autoreleasepool {

		NSArray *draggedFiles = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
		NSString *lastFilePath = draggedFiles.lastObject;

		NSFileManager *fileManager = [NSFileManager defaultManager];
		BOOL isDirectory;

		[fileManager fileExistsAtPath:lastFilePath isDirectory:&isDirectory];

		if (self.shouldUseFileData)
			[self setImage:[[NSImage alloc] initWithContentsOfFile:lastFilePath]];
		else
			[self setImage:[[NSWorkspace sharedWorkspace] iconForFile:lastFilePath]];

		[self.delegate dragAndDropView:self didReceiveDroppedSource:lastFilePath shouldUseFileData:self.shouldUseFileData];
	}

	return YES;
}

@end

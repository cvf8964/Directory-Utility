//
//  GBFolderDocument.m
//  Icon Changer
//
//  Created by Andrew A.A. on 12/5/12.
//  Copyright (c) 2012 Andrew A.A. All rights reserved.
//

#import "GBFolderDocument.h"
#import <AppKit/NSFileWrapperExtensions.h>

@interface GBFolderDocument ()

@property (unsafe_unretained) IBOutlet NSWindow *mainWindow;

@property (nonatomic, strong) NSFileWrapper *fileWrapper;
@property (nonatomic, strong) IBOutlet GBDragAndDropView *folderIconView;

@end

@implementation GBFolderDocument


- (id)initWithContentsOfURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError
{
	self = [super initWithContentsOfURL:url ofType:typeName error:outError];
	if (self) {

	}

	return self;
}

- (NSString *)windowNibName
{
    return @"Folder Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
	[super windowControllerDidLoadNib:aController];

	[self.folderIconView setDelegate:self];
	[self.folderIconView setImage:[[NSWorkspace sharedWorkspace] iconForFile:self.fileURL.path]];
}

- (BOOL)readFromFileWrapper:(NSFileWrapper *)fileWrapper ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError
{
	[self setFileWrapper:fileWrapper];
	
	return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError *__autoreleasing *)outError
{

	return nil;
}

- (void)dragAndDropView:(GBDragAndDropView *)view didReceiveDroppedSource:(NSString *)source shouldUseFileData:(BOOL)shouldUseFileData
{
	NSTask *task = [[NSTask alloc] init];

	if (shouldUseFileData)
		task.arguments = @[@"-d", source, self.fileURL.path];
	else
		task.arguments = @[source, self.fileURL.path];

	[task setLaunchPath:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"seticon"]];

	[task launch];
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

@end

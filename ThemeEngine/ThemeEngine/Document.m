//
//  Document.m
//  ThemeEngine
//
//  Created by Alexander Zielenski on 6/13/15.
//  Copyright © 2015 Alex Zielenski. All rights reserved.
//

#import "Document.h"
#import "NSURL+Paths.h"

static NSString *const TKCarPathSystemAppearance = @"/System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/SystemAppearance.car";
static NSString *const TKCarPathAssets           = @"/System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/Assets.car";

@interface Document () <NSTableViewDelegate>
@property (copy) NSURL *tmpURL;
@end

@implementation Document

- (instancetype)init {
    if ((self = [super init])) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
    aController.window.titleVisibility            = NSWindowTitleHidden;
    aController.window.appearance                 = [NSAppearance currentAppearance];
    aController.window.titlebarAppearsTransparent = YES;
}

- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}

- (BOOL)writeToURL:(NSURL *)absoluteURL ofType:(NSString *)typeName forSaveOperation:(NSSaveOperationType)saveOperation originalContentsURL:(NSURL *)absoluteOriginalContentsURL error:(NSError **)outError {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    switch (saveOperation) {
        case NSSaveOperation:
        case NSSaveToOperation: {
            // write our stuff to tmp on disk
            [self.assetStorage writeToDiskUpdatingChangeCounts:YES];
            
            // copy the written information to the actual location
            if (![manager copyItemAtPath:self.tmpURL.path
                                  toPath:absoluteURL.path
                                   error:outError]) {
                NSLog(@"%@", *outError);
                return NO;
            }
            
            break;
        }
        case NSSaveAsOperation: {
            NSURL *temporary = [[NSURL temporaryURLInSubdirectory:TKTemporaryDirectoryDocuments]
                                URLByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
            
            
            // copy current stuff to another tmp location
            if (![manager copyItemAtPath:self.tmpURL.path
                                  toPath:temporary.path
                                   error:outError]) {
                return NO;
            }
            
            // write to disk
            [self.assetStorage writeToDiskUpdatingChangeCounts:NO];
            // move newly written stuff to destination
            if (![manager moveItemAtURL:self.tmpURL
                                  toURL:absoluteURL
                                  error:outError]) {
                return NO;
            }
            
            // move our copied stuff back into the original tmp location
            if (![manager moveItemAtURL:temporary
                                  toURL:self.tmpURL
                                  error:outError]) {
                return NO;
            }
            break;
        }
        default: {
            return NO;
            break;
        }
    }
    
    return YES;
}

- (BOOL)readFromURL:(nonnull NSURL *)url ofType:(nonnull NSString *)typeName error:(NSError * __nullable __autoreleasing * __nullable)outError {
    NSFileManager *manager = [NSFileManager defaultManager];
//    if (![manager isWritableFileAtPath:url.path]) {
//        //!TODO: Prompt to user to ask if we should move to a temporary location
//        //! or open just for viewing
//        return NO;
//    }

    NSURL *temporary = [[NSURL temporaryURLInSubdirectory:TKTemporaryDirectoryDocuments]
                        URLByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    if (![manager copyItemAtURL:url
                          toURL:temporary
                          error:outError]) {
        return NO;
    }
    
    self.tmpURL = temporary;
    self.assetStorage = [TKMutableAssetStorage assetStorageWithPath:temporary.path];
    
    if (!self.assetStorage) {
        *outError = [NSError errorWithDomain:NSBundle.mainBundle.bundleIdentifier
                                        code:-1
                                    userInfo:@{
                                               NSLocalizedFailureReasonErrorKey: @"Failed to read contents of car file",
                                               NSLocalizedRecoverySuggestionErrorKey: @"Try another file"
                                               }];
        return NO;
    }
    
    self.undoManager = self.assetStorage.undoManager;
    
    return YES;
}

+ (BOOL)autosavesDrafts {
    return NO;
}

+ (BOOL)autosavesInPlace {
    return NO;
}

@end

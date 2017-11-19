#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>

#include "CreateSnapshot.h"

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize);
void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail);

/* -----------------------------------------------------------------------------
    Generate a thumbnail for file

   This function's job is to create thumbnail for designated file as fast as possible
   ----------------------------------------------------------------------------- */

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize)
{
    @autoreleasepool {
        NSRect rect = {0, 0, maxSize.width, maxSize.height};
        NSImage *snapshot = CreateSnapshot((__bridge NSURL*)url, rect);

        CGContextRef cgContext = QLThumbnailRequestCreateContext(thumbnail, rect.size, false, options);
        if(cgContext){
            NSGraphicsContext *context = [NSGraphicsContext graphicsContextWithGraphicsPort:cgContext flipped:true];
            
            if(context){
                [NSGraphicsContext saveGraphicsState];
                [NSGraphicsContext setCurrentContext:context];
                
                [snapshot drawInRect:rect fromRect:rect operation:NSCompositingOperationSourceOver fraction:1.0];
                [NSGraphicsContext restoreGraphicsState];
            }
            QLThumbnailRequestFlushContext(thumbnail, cgContext);
            CFRelease(cgContext);
        } else {
            return 1;
        }
        return noErr;
    }
}

void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail)
{
    // Implement only if supported
}

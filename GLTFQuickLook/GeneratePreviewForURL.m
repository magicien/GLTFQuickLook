#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>

#include "CreateSnapshot.h"

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options);
void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview);

/* -----------------------------------------------------------------------------
   Generate a preview for file

   This function's job is to create preview for designated file
   ----------------------------------------------------------------------------- */

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
    @autoreleasepool {
        NSRect rect = {0, 0, 800, 800};
        NSImage *snapshot = CreateSnapshot((__bridge NSURL*)url, rect);

        CGContextRef cgContext = QLPreviewRequestCreateContext(preview, rect.size, false, options);
        if(cgContext){
            NSGraphicsContext *context = [NSGraphicsContext graphicsContextWithGraphicsPort:cgContext flipped:true];
            
            if(context){
                [NSGraphicsContext saveGraphicsState];
                [NSGraphicsContext setCurrentContext:context];
                
                [snapshot drawInRect:rect fromRect:rect operation:NSCompositingOperationSourceOver fraction:1.0];
                [NSGraphicsContext restoreGraphicsState];
            }
            QLPreviewRequestFlushContext(preview, cgContext);
            CFRelease(cgContext);
        } else {
            return 1;
        }
        return noErr;
    }
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview)
{
    // Implement only if supported
}

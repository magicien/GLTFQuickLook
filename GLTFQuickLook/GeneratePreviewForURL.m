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
        GLTFSceneSource *source = [[GLTFSceneSource alloc] initWithURL:(__bridge NSURL*)url options:nil];
        SCNScene *scene = [source sceneWithOptions:nil error:nil];

        NSData *scnData = [NSKeyedArchiver archivedDataWithRootObject:scene];
        CFStringRef contentTypeUTI = CFSTR("com.apple.scenekit.scene");
        
        QLPreviewRequestSetDataRepresentation(preview, (__bridge CFDataRef)(scnData), contentTypeUTI, options);
        
        return noErr;
    }
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview)
{
    // Implement only if supported
}

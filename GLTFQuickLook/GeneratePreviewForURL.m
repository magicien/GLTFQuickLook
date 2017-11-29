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

        if(QLPreviewRequestIsCancelled(preview)){
            return noErr;
        }

        NSData *scnData = [NSKeyedArchiver archivedDataWithRootObject:scene];

        if(QLPreviewRequestIsCancelled(preview)){
            return noErr;
        }

        QLPreviewRequestSetDataRepresentation(preview, (__bridge CFDataRef)(scnData), kUTType3DContent, nil);
        
        return noErr;
    }
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview)
{
    // Implement only if supported
}

#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>

#import <SceneKit/SceneKit.h>
@import GLTFSceneKit;

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
        GLTFSceneSource *source = [[GLTFSceneSource alloc] initWithURL:(__bridge NSURL*)url options:nil];
        SCNScene *scene = [source sceneWithOptions:nil error:nil];
        
        CGFloat __block minX = CGFLOAT_MAX;
        CGFloat __block minY = CGFLOAT_MAX;
        CGFloat __block minZ = CGFLOAT_MAX;
        CGFloat __block maxX = CGFLOAT_MIN;
        CGFloat __block maxY = CGFLOAT_MIN;
        CGFloat __block maxZ = CGFLOAT_MIN;
        
        [scene.rootNode enumerateChildNodesUsingBlock:^(SCNNode * _Nonnull child, BOOL * _Nonnull stop) {
            if(child.geometry != nil){
                SCNVector3 childMin;
                SCNVector3 childMax;
                [child.geometry getBoundingBoxMin:&childMin max:&childMax];
                
                minX = MIN(minX, childMin.x + child.worldPosition.x);
                minY = MIN(minY, childMin.y + child.worldPosition.y);
                minZ = MIN(minZ, childMin.z + child.worldPosition.z);
                maxX = MAX(maxX, childMax.x + child.worldPosition.x);
                maxY = MAX(maxY, childMax.y + child.worldPosition.y);
                maxZ = MAX(maxZ, childMax.z + child.worldPosition.z);
            }
        }];
        printf("min: %f %f %f max: %f %f %f\n", minX, minY, minZ, maxX, maxY, maxZ);
        
        SCNNode *cameraNode = [SCNNode node];
        cameraNode.camera = [SCNCamera camera];
        printf("fov: %f\n", cameraNode.camera.fieldOfView); // 60.0 deg.
        
        cameraNode.camera.automaticallyAdjustsZRange = true;
        CGFloat dz = MIN(MAX(maxX - minX, maxY - minY), 1000.0);
        if(cameraNode.camera.zNear > dz){
            cameraNode.camera.zNear = dz;
        }
        CGFloat wz = dz + maxZ - minZ;
        if(cameraNode.camera.zFar < wz){
            cameraNode.camera.zFar = wz;
        }
        CGFloat cameraX = (minX + maxX) / 2;
        CGFloat cameraY = (minY + maxY) / 2;
        CGFloat cameraZ = maxZ + dz;
        printf("camera: %f %f %f\n", cameraX, cameraY, cameraZ);

        cameraNode.position = SCNVector3Make(cameraX, cameraY, cameraZ);
        [scene.rootNode addChildNode:cameraNode];
        
        SCNView *view = [[SCNView alloc] initWithFrame:rect options:nil];
        view.backgroundColor = NSColor.whiteColor;
        view.autoenablesDefaultLighting = true;
        view.scene = scene;
        view.pointOfView = cameraNode;
        NSImage *snapshot = [view snapshot];
        
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

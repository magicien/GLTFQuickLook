//
//  CreateSnapshot.m
//  GLTFQuickLook
//
//  Created by magicien on 11/19/17.
//  Copyright © 2017 DarkHorse. All rights reserved.
//

#include "CreateSnapshot.h"

NSImage* CreateSnapshot(NSURL *url, NSRect frame) {
    @autoreleasepool {
        GLTFSceneSource *source = [[GLTFSceneSource alloc] initWithURL:url options:nil];
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
        
        SCNView *view = [[SCNView alloc] initWithFrame:frame options:nil];
        view.backgroundColor = NSColor.whiteColor;
        view.autoenablesDefaultLighting = true;
        view.scene = scene;
        view.pointOfView = cameraNode;
        NSImage *snapshot = [view snapshot];
        
        return snapshot;
    }
}

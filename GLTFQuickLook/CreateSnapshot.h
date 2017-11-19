//
//  CreateSnapshot.h
//  GLTFQuickLook
//
//  Created by magicien on 11/19/17.
//  Copyright © 2017 DarkHorse. All rights reserved.
//

#ifndef CreateSnapshot_h
#define CreateSnapshot_h

#include <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>
@import GLTFSceneKit;

NSImage* CreateSnapshot(NSURL *url, NSRect frame);

#endif /* CreateSnapshot_h */

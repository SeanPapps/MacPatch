//
//  Constants.h
/*
 Copyright (c) 2013, Lawrence Livermore National Security, LLC.
 Produced at the Lawrence Livermore National Laboratory (cf, DISCLAIMER).
 Written by Charles Heizer <heizer1 at llnl.gov>.
 LLNL-CODE-636469 All rights reserved.
 
 This file is part of MacPatch, a program for installing and patching
 software.
 
 MacPatch is free software; you can redistribute it and/or modify it under
 the terms of the GNU General Public License (as published by the Free
 Software Foundation) version 2, dated June 1991.
 
 MacPatch is distributed in the hope that it will be useful, but WITHOUT ANY
 WARRANTY; without even the IMPLIED WARRANTY OF MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE. See the terms and conditions of the GNU General Public
 License for more details.
 
 You should have received a copy of the GNU General Public License along
 with MacPatch; if not, write to the Free Software Foundation, Inc.,
 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#import <Cocoa/Cocoa.h>

extern NSString * const MP_ROOT;
extern NSString * const MP_ROOT_CLIENT;
extern NSString * const MP_ROOT_SERVER;
extern NSString * const MP_ROOT_UPDATE;

extern NSString * const AGENT_EXEC;
extern NSString * const AGENT_VER_PLIST;
extern NSString * const AGENT_PREFS_PLIST;
extern NSString * const AGENT_FRAMEWORK_PATH;
extern NSString * const APP_PREFS_PLIST;

extern NSString * const WS_NAMESPACE;
extern NSString * const WS_CONTROLLER_FILE;

extern NSString * const ASUS_BIN_PATH;
extern NSString * const ASUS_APP_PATH;
extern NSString * const ASUS_PLIST_PATH;

extern NSString * const CLIENT_PATCH_STATUS_FILE;
extern NSString * const SELF_PATCH_PATH;
extern NSString * const MPREBOOT_APP_PATH;
extern NSString * const MPLOGOUT_APP_PATH;
extern NSString * const MPLOGOUT_BIN_PATH;
extern NSString * const MPLOGOUT_HOOK_PLIST;

extern NSString * const SWDIST_APP_PATH;
extern NSString * const MP_SWDIST_WORK_DIR;

extern NSString * const SYSPROFILE_BIN_PATH;
extern NSString * const INSTALLER_BIN_PATH;

extern NSString * const kMPPatchSCAN;
extern NSString * const kMPPatchUPDATE;
extern NSString * const kMPInventory;
extern NSString * const kMPAVUpdate;

extern NSString * const MP_XSD_AUDIT;

@interface Constants : NSObject {

}

@end

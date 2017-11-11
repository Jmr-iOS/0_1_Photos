/************************************************************************************************************************************/
/** @class      Music
 *  @proj       0_1- Music
 *
 *  @auth       Created by Justin Reina on 10/30/17
 *  @cpr        Copyright © 2017 Jmr. All rights reserved
 *
 *  @section    Hide strange unwanted Xcode logs
 *        https://stackoverflow.com/questions/37800790/hide-strange-unwanted-xcode-logs
 *
 *  @section   Music Access
 *       https://stackoverflow.com/questions/40445062/how-to-access-music-files-stored-on-the-ios-device
 *
 *  @section     Media Player Integration
 *       http://www.theappguruz.com/blog/integrating-media-player-ios-using-swift
 *
 *  @section    Authorization
 *       MPMediaLibrary.authorizationStatus
 *
 *  @section   Next Steps
 *       - Print listing of artists to console
 *
 *  @section    MPMediaLibraryAuthorizationStatus
 *      case notDetermined: (0)The user hasn't determined whether to authorize the use of their media library.
 *             case denied: (1)The app may not access the items in the user's media library.
 *         case restricted: (2)The app may access some of the content in the user's media library.
 *         case authorized: (3)Your app may access items in the user's media library.
 *
 */
/************************************************************************************************************************************/
import UIKit
import MediaPlayer


class Music: NSObject {

    let authLvls : [String] = ["notDetermined", "denied", "restricted", "authorized"];

    override init() {
        super.init();
        
        print("Music...");

        print(" ");
        print("//----------------------//");
        
        let query = MPMediaQuery();

        print("//--------A--------//");

        let result = query.items;
        
        print("//--------B--------//");
        
        let rslt : MPMediaLibraryAuthorizationStatus = MPMediaLibrary.authorizationStatus();
        let rslt_val : Int = rslt.rawValue;
        
        print("Access level on device found as '\(authLvls[rslt_val])'");
        
        
        if(MEDIA_LIB_AUTH_AUTHORIZED != rslt.rawValue) {
            print("Not authorized for library access, aborting.");
            return;
        }
        
        print("//----------------------//");
        print(" ");

        
        if(result != nil) {
            print("Found", result!.count, "files");
        } else {
            print("No music found on device");
        }
        
        return;
    }
}


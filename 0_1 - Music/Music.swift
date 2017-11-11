/************************************************************************************************************************************/
/** @class      Music
 *  @proj       0_1- Music
 *  @brief      x
 *  @details    x
 *
 *  @auth       Created by Justin Reina on 11/11/17
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
 *      case denied: (1)The app may not access the items in the user's media library.
 *      case restricted: (2)The app may access some of the content in the user's media library.
 *      case authorized: (3)Your app may access items in the user's media library.
 */
/************************************************************************************************************************************/
import UIKit
import MediaPlayer


class Music: NSObject {

    //Library Vars
    var query : MPMediaQuery;
    var media : [MPMediaItem];
    
    //Parse Vars
    var artists : [String];
    
    let authLvls : [String] = ["notDetermined", "denied", "restricted", "authorized"];

    /********************************************************************************************************************************/
    /** @fcn        override init()                                                                                                 */
    /*  @brief      init the var                                                                                                    */
    /*  @post       query & media init                                                                                              */
    /*  @assum      query is valid                                                                                                  */
    /********************************************************************************************************************************/
    override init() {
        
        //Init
        self.query = MPMediaQuery();                                    /* grab handle                                              */
        self.media = self.query.items!;                                 /* grab media listing                                       */
        self.artists = [];                                              /* init empty                                               */
        super.init();
        
        //Find the media
        let result = query.items;
        
        //Check auth
        let rslt : MPMediaLibraryAuthorizationStatus = MPMediaLibrary.authorizationStatus();
        let rslt_val : Int = rslt.rawValue;
        
        //Handle auth
        print("Access level on device found as '\(authLvls[rslt_val])'");
        
        if(MEDIA_LIB_AUTH_AUTHORIZED != rslt.rawValue) {
            print("Not authorized for library access, aborting.");
            return;
        }
        
        //Check Media
        if(result != nil) {
            print("Found", result!.count, "files");
        } else {
            print("No music found on device");
        }
        
        return;
    }
    
    /********************************************************************************************************************************/
    /** @fcn        func parseArtists()
     *  @brief      get listing of artists in library
     *  @details    x
     *
     *  @pre    query & media init
     *  @post   artists pop
     *
     *  @section    Notes
     *        media.count is lib size of songs
     *
     *  @section    Todo
     *      parse and store albums
     *      parse and store songs
     */
    /********************************************************************************************************************************/
    func parseArtists() {

        //Grab
        for i in 1...(media.count-1) {
            
            //only if found in file
            if(nil != media[i].albumArtist) {
            
                let newArtist : String = media[i].albumArtist!;

                //Check if existing in artists
                if(!self.artists.contains(newArtist)) {
                    self.artists.append(newArtist);                                         /* append if not found                  */
                }
            }
        }
  
        print("done with \(self.artists.count) artists");
        return;
    }
}


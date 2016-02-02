//
//  DataService.swift
//  my-hood-Shawn
//
//  Created by Shawn on 1/8/16.
//  Copyright © 2016 Shawn. All rights reserved.
//

import Foundation
import UIKit
//Singleton is one instance in memory but globally accessible to everyone.

class DataService {
    static let instance = DataService() //static gives one instance only
    
    let KEY_POSTS = "posts"
    private var _loadedPosts = [Post] () //initialize array to empty array for safety reasons
    
    var loadedPosts: [Post] {
        return _loadedPosts
    }
    
    func savePosts() {
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts) //turning array into data
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: KEY_POSTS) //main default sets key for value "postsData"
        NSUserDefaults.standardUserDefaults().synchronize() //saves data to disk
    }
    
    func loadPosts() {
        if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(KEY_POSTS) as? NSData {
            
            if let postsArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [Post] {
                _loadedPosts = postsArray
            }
        }
        
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil)) //notification when posts are loaded
    }
    
    //Saving images to path of documents
    
    func saveImageAndCreatePath(image: UIImage) -> String {
        let imgData = UIImagePNGRepresentation(image) //turns pic into PNG or data
        let imgPath = "image\(NSDate.timeIntervalSinceReferenceDate()).png" //creating string with unique name
        let fullPath = documentsPathForFileName(imgPath) //grabbing directory where we want to save it
        imgData?.writeToFile(fullPath, atomically: true) //atomically is safer way to safe data by backing it up
        return imgPath //stores the name of image
    }
    
    func imageForPath(path: String) -> UIImage? {
        let fullPath = documentsPathForFileName(path)
        let image = UIImage(named: fullPath)
        return image
    }
    
    func addPost(post: Post) {
        _loadedPosts.append(post)
        savePosts()
        loadPosts()
    }
    
    func documentsPathForFileName(name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) //grab path for image directory
        let fullPath = paths[0] as NSString //reason why we're casting it is that NSString gives us a function to append paths
        return fullPath.stringByAppendingPathComponent(name) //adding name of image to end of path
    }
}
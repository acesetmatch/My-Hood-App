//
//  ViewController.swift
//  my-hood-Shawn
//
//  Created by Shawn on 1/8/16.
//  Copyright © 2016 Shawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource { //delegate is a protocol

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DataService.instance.loadPosts()
        //tableView.estimatedRowHeight = 87 //labels can be flexible heights
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onPostsLoaded:", name: "postsLoaded", object: nil)
        
        //tableView.reloadData() //reloads all the functions and data for each post. REQUIRED!
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell { //delivers new cell and inputs data into that cell
        //Polymorphism use parent type the same as the childtype
        let post = DataService.instance.loadedPosts[indexPath.row] //indexPath.row asks for the index based on which row it is in. Similar to a for loop e.g 3rd row is index #2. //dataservice.instance.loadedposts retrives posts from class dataservice
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCellTableViewCell { //takes an old cell, cleans data out of it so it can be reused again
            cell.configureCell(post) //takes data from post where we at and update it in the cell
            return cell
        } else { //makes own cell if cell cannot be reused
            let cell = PostCellTableViewCell()
            cell.configureCell(post)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 87.0 //sets cell height
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.loadedPosts.count
    }
    
    func onPostsLoaded(notif:AnyObject) {
        tableView.reloadData()
    }
    
    
}


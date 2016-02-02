//
//  AddPostVCViewController.swift
//  my-hood-Shawn
//
//  Created by Shawn on 1/8/16.
//  Copyright © 2016 Shawn. All rights reserved.
//

import UIKit

class AddPostVCViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postImg.layer.cornerRadius = postImg.frame.size.width/2 //makes perfect circle
        postImg.clipsToBounds = true //anything outside of the circle is cut
        // Do any additional setup after loading the view.
        
        imagePicker = UIImagePickerController() //initializes the imagePicker
        imagePicker.delegate = self
    }

    
    @IBAction func addPicBtnPressed(sender: UIButton!) {
        sender.setTitle("", forState: .Normal)
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func makePostBtnPressed(sender: AnyObject) {
        if let title = titleField.text, let desc = descField.text, let img = postImg.image {
            
            let imgPath = DataService.instance.saveImageAndCreatePath(img)
            
            let post = Post(imagePath: imgPath, title: title, description: desc)
            DataService.instance.addPost(post)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    

    @IBAction func cancelBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) { //when users picks image
        imagePicker.dismissViewControllerAnimated(true, completion: nil) //dismisses controler
        postImg.image = image //saves images in imageview
    }
    
}

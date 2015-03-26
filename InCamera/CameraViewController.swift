//
//  ViewController.swift
//  InCamera
//
//  Created by Zhengshen Yin on 3/25/15.
//  Copyright (c) 2015 aprilY. All rights reserved.
//

import UIKit
import MobileCoreServices

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: backgroundImageView!
    
    var newMedia : Bool?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        //Custom Initialization
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
    }
    
    //program mark - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   // @IBAction func cameraShow(){
    //    self.presentCamera()
    //}
    
  
    //program mark - Camera
    @IBAction func useCamera(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.mediaTypes = [kUTTypeImage as NSString]
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
            newMedia = true
        }
        
    }
    
    @IBAction func useCameraRoll(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as NSString]
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
            newMedia = false
        }
    }
  

    //program mark - Image
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var mediaType:NSString = info[UIImagePickerControllerMediaType] as NSString
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if mediaType.isEqualToString(kUTTypeImage as NSString){
            let image = info[UIImagePickerControllerOriginalImage] as UIImage
            imageView.image = image
            if newMedia == true{
                UIImageWriteToSavedPhotosAlbum(image, self, "image: didFinishSavingWithError", nil)
            }else if mediaType.isEqualToString(kUTTypeMovie as NSString){
                //code to support video here
                
            }
            
        }
        
    }
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafeMutablePointer<Void>){
        if error != nil{
            let alert = UIAlertController(title: "Save Failed", message: "Falied to save image", preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
 
}


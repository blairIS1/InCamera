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
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var cameraUI:UIImagePickerController = UIImagePickerController()
    
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
        self.presentCamera()
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
    
    func presentCamera(){
        cameraUI = UIImagePickerController()
        cameraUI.delegate = self
        cameraUI.sourceType = UIImagePickerControllerSourceType.Camera
        cameraUI.mediaTypes = [kUTTypeImage]
        cameraUI.allowsEditing = false
        self.presentViewController(cameraUI, animated: true, completion: nil)
        
    }

    //program mark - Image
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info:NSDictionary) {
        
        var mediaType:NSString = info.objectForKey(UIImagePickerControllerEditedImage) as NSString
        var imageToSave:UIImage
        imageToSave = info.objectForKey(UIImagePickerControllerOriginalImage) as UIImage
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil , nil)
        self.savedImage()
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    func savedImage(){
        var alert: UIAlertView = UIAlertView()
        alert.title = "Saved!"
        alert.message = "Your picture was saved to Camera Roll"
        alert.delegate = self
        alert.addButtonWithTitle("Awesome")
        alert.show()
    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        NSLog("Did dismiss button: %d", buttonIndex)
        self.presentCamera()
    }
}


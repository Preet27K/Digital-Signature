//
//  SignatureManager.swift
//  Expand Track
//
//  Created by Apple3 on 02/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation

class SignatureManager: NSObject {
    //MARK:- Variables
    var signature: UIImage? {
        didSet {
            self.saveSignature()
        }
    }
    
    //MAKR:- Clasures
    var signatureSaved:((Bool, String)->())?
    
    //Save Signature in DocumentDirectory
    private func saveSignature() {
        if let signatureImage = signature {
            
            //Save image in document directory
            let imageData = signatureImage.pngData()
            //Generate unique name according to your requirement
            let fileName = "signature.png"
            
            let url = NSURL(fileURLWithPath: getDocumentsDirectory())
            
            if let logsPath = url.appendingPathComponent("Signature") {
                do {
                    try FileManager.default.createDirectory(atPath: logsPath.path, withIntermediateDirectories: true, attributes: nil)
                    
                } catch let error as NSError {
                    NSLog("Unable to create directory \(error.debugDescription)")
                }
                
                let pathComponent = logsPath.appendingPathComponent(fileName)
                //let filePath = pathComponent.path
                do{
                    try imageData?.write(to: pathComponent, options: [])
                    signatureSaved?(true, "Signature saved successfully")
                }catch{
                    print("\n")
                    print(error)
                    signatureSaved?(false, error.localizedDescription)
                }
            }
        }
    }
    
    //MARK:- Fetch Signature
    private func getSignature() -> UIImage {
        //get signatue from file
        let url = NSURL(fileURLWithPath: getDocumentsDirectory())
        
        if let logsPath = url.appendingPathComponent("Signature") {
            let pathComponent = logsPath.appendingPathComponent("signature.png")
            
            let image = UIImage(contentsOfFile: pathComponent.path)
            return image ?? UIImage()
        }
        
        return signature ?? UIImage()
    }
    
    //Document directory path
    private func getDocumentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}


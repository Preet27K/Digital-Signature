//
//  ViewController.swift
//  DigitalSignature
//
//  Created by Simran on 22/11/18.
//  Copyright © 2018 Simran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- Variables
    var signatureManager: SignatureManager!
    
    //IBOutlets
    @IBOutlet weak var buttonSaveSignature: UIButton!
    @IBOutlet weak var buttonClearSignature: UIButton!
    @IBOutlet weak var viewSignature: SignatureView!
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- IBAction
    @IBAction func clearSignatureTap() {
        //Clear signature
        viewSignature.clear()
        buttonSaveSignature.isHidden = true
        buttonClearSignature.isHidden = true
    }
    
    @IBAction func saveSignatureTap() {
        
        guard let signatureImage = viewSignature.getSignature() else {
            return
        }
        
        //Signature Save in document Directory
        signatureManager = SignatureManager()
        signatureManager.signatureSaved = { (status, message) in
            print(message)
            if status {
                
                // Do further actions
            } else {
                //Show error alert
            }
        }
        signatureManager.signature = signatureImage
        
    }
}

//MARK:- Extension SwiftSignatureViewDelegate
extension ViewController: SignatureViewDelegate {
    func signatureViewDidTapInside(_ view: SignatureView) {
        self.signatureWritingDidStart()
    }
    
    func signatureViewDidPanInside(_ view: SignatureView) {
        self.signatureWritingDidStart()
    }
    
    private func signatureWritingDidStart() {
        buttonClearSignature.isHidden = false
        buttonSaveSignature.isHidden = false
    }
}

//
//  ViewController.swift
//  MayTermApp
//
//  Created by Walt Boettge on 5/30/18.
//  Copyright © 2018 Walt Boettge. All rights reserved.
//

import UIKit
import SwiftSocket

class ViewController: UIViewController {
    
    let host = "73.94.99.15"
    let port = 3141
    var client: TCPClient?

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var lightBG: UIView!
    @IBOutlet weak var darkBG: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configureTapGesture()
        
        client = TCPClient(address: host, port: Int32(port))
        //field.delegate = self
        guard let client = client else { return }
        print("Pressed")
        switch client.connect(timeout: 1) {
        case .success:
            print("Connected")
            label.text = "Connected: Lights are \(readData(using: client))"
        case .failure(let error):
            print("Failed")
            label.text = String(describing: error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnPress(_ sender: Any) {
        label.text = "On"
        sendMessage(string: "On", using: client!)
        lightBG.isHidden = false
        darkBG.isHidden = true
        label.textColor = UIColor.black
    }
    
    @IBAction func offBtnPress(_ sender: Any) {
        label.text = "Off"
        sendMessage(string: "Off", using: client!)
        lightBG.isHidden = true
        darkBG.isHidden = false
        label.textColor = UIColor.white
    }
    
    private func readData(using client: TCPClient) -> String {
        var bytes = client.read(1024)
        while(bytes == nil){
            bytes = client.read(1024)
        }
        
        if let string = String(bytes: bytes!, encoding: .utf8) {
            let index = string.index(string.endIndex, offsetBy: -1)
            let mySubstring = string.prefix(upTo: index)
            return String(mySubstring)
        } else {return ""}
    }

    private func sendMessage(string: String, using client: TCPClient) -> String? {
        switch client.send(string: "\(string)\n") {
        case .success:
            return nil
        case .failure(let error):
            label.text = String(describing: error)
            return nil
        }
    }
    /*
     private func configureTapGesture() {
     let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
     view.addGestureRecognizer(tapGesture)
     }
     
     
     @objc func handleTap() {
     view.endEditing(true)
     }
     */
    
}
/*
extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        sendMessage(string: field.text!, using:client!)
        textField.text = ""
        return true
    }
}
*/

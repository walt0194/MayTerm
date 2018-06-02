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
    
    let host = "10.0.0.34"
    let port = 6374
    var client: TCPClient?

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        client = TCPClient(address: host, port: Int32(port))
        field.delegate = self
        guard let client = client else { return }
        print("Pressed")
        switch client.connect(timeout: 1) {
        case .success:
            print("Connected")
            label.text = "Connected"
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
        label.text = field.text
        sendMessage(string: field.text!, using: client!)
    }
    
    private func sendMessage(string: String, using client: TCPClient) -> String? {
        switch client.send(string: "\(string)\n") {
        case .success:
            return "Success"
        case .failure(let error):
            label.text = String(describing: error)
            return nil
        }
    }
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


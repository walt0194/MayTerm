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
    
    let client = TCPClient(address: "73.94.99.15", port: 6394)

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        field.delegate = self
        
        switch client.connect(timeout: 10) {
        case .success:
            label.text = "connected"
        case .failure(let error):
            label.text = String(describing: error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnPress(_ sender: Any) {
        client.send(string: field.text!)
        label.text = field.text
    }
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


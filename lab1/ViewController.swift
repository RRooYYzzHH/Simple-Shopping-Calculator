//
//  ViewController.swift
//  lab1
//
//  Created by RoYzH on 1/26/17.
//  Copyright © 2017 RoYzH. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var results: UILabel!
    
    @IBOutlet weak var originalPrice: UITextField!
    
    @IBOutlet weak var tax: UITextField!
    
    @IBOutlet weak var discount: UITextField!
    
    @IBOutlet weak var pbd: UILabel!
    
    @IBOutlet weak var pad: UILabel!
    
    @IBOutlet weak var finalDiscount: UILabel!
    
    //handle the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let inverseSet = NSCharacterSet(charactersIn:"0123456789.").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")  
        return string == filtered
    }
    
    
    var p = Float(0)
    var d = Float(0)
    var t = Float(0)
    
    func updatePrice(_ textField: UITextField) {
        if(originalPrice.text == "") {
            p = Float(0);
        }
        else {
            p = Float(originalPrice.text!)!;
        }
        results.text = String(format:"%.2f", p * (1-d) * (1+t));
        pbd.text = String(format:"%.2f", p * (1+t));
        pad.text = String(format:"%.2f", p * (1-d) * (1+t));
        finalDiscount.text = String(format:"%.2f", p * (1+t) * d);
    }

    
    func updateDiscount(_ textField: UITextField) {
        if(discount.text == "") {
            d = Float(0);
        }
        else if(Float(discount.text!)! > 100) {
            d = Float(1);
        }
        else {
            d = Float(discount.text!)! / 100;
        }
        results.text = String(format:"%.2f", p * (1-d) * (1+t));
        pbd.text = String(format:"%.2f", p * (1+t));
        pad.text = String(format:"%.2f", p * (1-d) * (1+t));
        finalDiscount.text = String(format:"%.2f", p * (1+t) * d);
    }
    
    func updateTax(_ textField: UITextField) {
        if(tax.text == "") {
            t = Float(0);
        }
        else {
            t = Float(tax.text!)! / 100;
        }
        results.text = String(format:"%.2f", p * (1-d) * (1+t));
        pbd.text = String(format:"%.2f", p * (1+t));
        pad.text = String(format:"%.2f", p * (1-d) * (1+t));
        finalDiscount.text = String(format:"%.2f", p * (1+t) * d);
    }
    
    @IBAction func Clear(_ sender: UIButton) {
        p = Float(0);
        d = Float(0);
        t = Float(0);
        results.text = "";
        originalPrice.text = "";
        discount.text = "";
        tax.text = "";
        pbd.text = "";
        pad.text = "";
        finalDiscount.text = "";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        results.layer.borderWidth = 1.0
        pbd.layer.borderWidth = 1.0
        pad.layer.borderWidth = 1.0
        finalDiscount.layer.borderWidth = 1.0
        
        originalPrice.addTarget(self, action: #selector(updatePrice(_:)), for: .editingChanged);
        
        discount.addTarget(self, action: #selector(updateDiscount(_:)), for: .editingChanged);
        
        tax.addTarget(self, action: #selector(updateTax(_:)), for: .editingChanged);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


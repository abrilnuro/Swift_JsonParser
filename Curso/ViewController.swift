//
//  ViewController.swift
//  Curso
//
//  Created by Miguel Canobbio on 27/08/16.
//  Copyright © 2016 Canobbio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,
                                  sender: AnyObject?) {
        
        if segue.identifier == "showSecondController" {
            
            let viewController = segue.destinationViewController as! HijoViewController
            
            viewController.textoRecibido = textField.text
            
            
        }
    }

}


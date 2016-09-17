//
//  SecondViewController.swift
//  Curso
//
//  Created by Miguel Canobbio on 27/08/16.
//  Copyright © 2016 Canobbio. All rights reserved.
//

import UIKit

class HijoViewController: UIViewController {
    
    var textoRecibido : String?
    
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = textoRecibido!
        
        // Do any additional setup after loading the view.
    }


}

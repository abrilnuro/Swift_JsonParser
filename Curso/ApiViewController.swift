//
//  ApiViewController.swift
//  Curso
//
//  Created by 02Caffeinelabs on 9/17/16.
//  Copyright © 2016 Canobbio. All rights reserved.
//

import UIKit
import Alamofire

class ApiViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPlaces()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Funcion para hacer un get en la api
    func getPlaces(){
        let URL : String = "http://192.241.141.182/api/index"
        
        Alamofire.request(.GET,URL).responseJSON {
            response in
            do{
                //validar que el response tenga algo
                if let JSON = response.result.value{
                    //imprimir lo que trae el response
                    print("JSON: \(JSON)")
                }
            }
            
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
    }
}

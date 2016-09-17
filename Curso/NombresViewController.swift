//
//  NombresViewController.swift
//  Curso
//
//  Created by Miguel Canobbio on 03/09/16.
//  Copyright © 2016 Canobbio. All rights reserved.
//

import UIKit
import Alamofire


class NombresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    //var nombres = [Usuario]()
    var lugares = [Lugar]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* var n = 0
        while n<3 {
            let usuario = Usuario()
            usuario.edad = n
            usuario.nombre = "Fulanito \(n)"
            nombres.append(usuario)
            n += 1
        }*/
        
        //llamar la funcion que me mostrara los satos del json en el tableView
        getPlaces(24.768183, long: -107.451288)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
           /* let cell : UsuarioTableViewCell = tableView.dequeueReusableCellWithIdentifier("UsuarioCell") as! UsuarioTableViewCell
            
            let usuario: Usuario?
            //usuario = nombres[indexPath.row]
            
            cell.edadLabel.text = String(usuario!.edad)
            cell.nombreLabel.text = usuario!.nombre
            
            return cell*/
            
            //declarar el objeto de celda
            let cell = tableView.dequeueReusableCellWithIdentifier("LugarCell") as! UsuarioTableViewCell
            //instanciar un objeto del arreglo de lugares
            //indexPath.row = me da la posicion de la celda
            let lugar = lugares[indexPath.row]
            
            
            cell.edadLabel.text = "\(lugar.id)"
            cell.nombreLabel.text = lugar.nombre
            
            let url  = NSURL(string: "http://192.241.141.182\(lugar.imageUrl)")
            
            //hacer la peticion de la imagen
            NSURLSession.sharedSession().dataTaskWithURL(url!){
                (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                dispatch_async(dispatch_get_main_queue(), {
                    () -> Void in
                    
                    //si hubo un error
                    if error != nil{
                        //asignar una imagen por default
                        cell.imagen.image = UIImage()
                    }else{
                        //mostrar la imagen que obtubimos de la url
                        cell.imagen.image = UIImage(data: data!)
                    }
                })
            }.resume()
            
            
            return cell
            
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return nombres.count
        return lugares.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    //Hacer la solicitud para obtener todos los lugares
    func getPlaces(lat: Double, long: Double){
        
        let url = "http://192.241.141.182/api/near_you"
        //crear un diccionario
        let postParams: Dictionary<String, AnyObject> = ["location":[
            "lat": lat, "long": long]]
        
        Alamofire.request(.POST, url, parameters: postParams)
            .responseJSON{
                response in
                do{
                    //mandar a parsear
                    //self = this
                    self.lugares = try JSONParser.parsePlaces(response.data!)
                    self.tableView.reloadData()
                }catch let error as NSError{
                    print(error)
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

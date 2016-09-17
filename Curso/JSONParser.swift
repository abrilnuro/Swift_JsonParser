//
//  JSONParser.swift
//  Curso
//
//  Created by 02Caffeinelabs on 9/17/16.
//  Copyright © 2016 Canobbio. All rights reserved.
//

import Foundation

class JSONParser{

    static func parsePlaces(data: NSData)throws -> [Lugar]{
        
        //Guardar el parametro(JSON) que me enviaron, en un diccionario.
        let dictionary : NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)as! NSDictionary
        
        //crear un arreglo
        var lugares : [Lugar] = []
        
        //si existe el arreglo
        if let lugaresArray = dictionary.valueForKey("places")as? NSArray{
            for lugar in lugaresArray{
                let l = lugar.valueForKey("place")as! NSDictionary

                let lugar = Lugar()
                
                lugar.id = l.valueForKey("id") as! Int
                lugar.nombre = l.valueForKey("name") as! String
                lugar.imageUrl = l.valueForKey("logo") as! String
                
                //agregar el objeto de lugar a mi arreglo con los valores que quiero
                lugares.append(lugar)
            }
        }
        
        
        return lugares
    }

}

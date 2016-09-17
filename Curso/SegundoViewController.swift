//
//  SegundoViewController.swift
//  Curso
//
//  Created by Miguel Canobbio on 10/09/16.
//  Copyright © 2016 Canobbio. All rights reserved.
//

import UIKit

class SegundoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var primerTextField: UITextField!
    @IBOutlet weak var segundoTextField: UITextField!
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var activeTextField : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollTap: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SegundoViewController.scrollViewTapped(_:)))
        mainScrollView.addGestureRecognizer(scrollTap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //1.- Que textfield está activo y se está editando
    //2.- cuando el teclado aparece
    //3.- altura del teclado
    //4.- convertir frame de ContentView al tamaño que se está mostrando en pantalla
    // 4.1.- frame de vista actual (toda la vista) - altura del teclado
    //5.- el frame que sacamos en la vista 4, 
    //  5.1 si en la vista actual, el punto menor en y del frame del textfield Actual NO 
    //se está mostrando en pantalla, entonces haz Scroll hacía el punto menor en y del 
    //frame del textfield
    //6.- se aplastó afuera de un textfield (ScrollView)
    //7.- ¿cuándo el teclado se esconde?
    
    //CUANDO EL TEXTFIELD ESTÁ ACTIVO
    
    //1.- ¿se aplastó la tecla de retorno (enter)?
    // si sabemos que existe otro textfield, 
    // le asignamos el firstResponder al siguiente textfield
    /*    SI NO entonces reasignamos el firstResponder a la pantalla
     
     
     */
    
    //se presionó afuera de un textfield
    func scrollViewTapped(recognizer: UIGestureRecognizer) {
        //reasignar manualmente el first responder (ahora será la pantalla)
        mainScrollView.endEditing(true)
    }
    
    //el teclado aparece o se muestra en pantalla
    override func viewWillAppear(animated: Bool) {
        //creamos un centro de notificaciones con defaultCenter
        let notificationCenter : NSNotificationCenter = NSNotificationCenter.defaultCenter()
        //agregamos un observador para cuando se recibe la notificacion de que el teclado es mostrado
        notificationCenter.addObserver(self, selector: #selector(SegundoViewController.keyboardWillBeShown),
                                       name: UIKeyboardWillShowNotification, object: nil)
        //agregamos un observador para cuando se recibe la notificacion de que el teclado se esconde
        notificationCenter.addObserver(self, selector: #selector(SegundoViewController.keyboardWillBeHidden),
                                       name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //El teclado desaparece
    override func viewWillDisappear(animated: Bool) {
        //borramos el observador creado cuando el teclado aparece
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //se ejecuta esta funcion cuando se recibe la notificacion de que el teclado se muestra
    func keyboardWillBeShown(sender: NSNotification) {
        print("El teclado es mostrado")
        //obtenemos la informacion de la notificacion recibida (sender)
        let info: NSDictionary = sender.userInfo!
        //buscamos la llave que contenga el frame del teclado
        let keyboardFrame : NSValue = info.valueForKey(UIKeyboardFrameBeginUserInfoKey) as! NSValue
        //al keyboardFrame le sacamos sus medidas
        let keyboardSize : CGSize = keyboardFrame.CGRectValue().size
        //obtenemos la altura del teclado
        let tabBarHeight = self.tabBarController?.tabBar.frame.height
        let keyboardHeight = (keyboardSize.height - tabBarHeight!)
        //creamos el tamaño que tendrá el scrollview y su posicion para moverse/mostrarse en su contenedor,,,,, 
        //top, left, bottom, right
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight, 0.0)
        //asignamos el contentInset que creamos con la altura del teclado
        mainScrollView.contentInset = contentInsets
        //asignamos el indicador de scroll (barra lateral) al mainscrollview
        mainScrollView.scrollIndicatorInsets = contentInsets
        
        //sacamos el frame.Rect de toda la vista
        /*var viewRect : CGRect = self.view.frame
        //a la altura de toda la vista visible le restamos
        //viewRect.size.height = viewRect.size.height - keyboardRectabgle.height
        viewRect.size.height -= keyboardSize.height
        //obtenemos el rectangulo del textfield activo
        let activeTextFieldRect: CGRect? = (activeTextField?.frame)!
        //obtenemos el punto de origen del textFieldActivo (el punto mas bajo)
        let activeTextFieldOrigin: CGPoint? = activeTextFieldRect?.origin
        if (!CGRectContainsPoint(viewRect, activeTextFieldOrigin!)) {
            mainScrollView.scrollRectToVisible(activeTextFieldRect!, animated: true)
        }*/
        
    }
    
    //se ejecuta esta funcion cuando se recibe la notificacion de que le teclado se esconde
    func keyboardWillBeHidden(sender: NSNotification) {
        print("El teclado se esconde")
        
        //creamos un contentInsets que sea igual a 0 en todas sus propiedades
        //let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        let contentInsets : UIEdgeInsets = UIEdgeInsetsZero
        
        //asignamos el contentInset que creamos (todos igual a 0) al mainscrollview
        mainScrollView.contentInset = contentInsets
        //asignamos el contentInsets que creamos al scrollindicator del mainscrollview
        mainScrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    //Un textfield comenzó ha ser editado
    func textFieldDidBeginEditing(textField: UITextField) {
        //asignamos el textfield recibido al activeTextField (variable global)
        self.activeTextField = textField
    }
    
    //Textfield dejó de ser editado
    func textFieldDidEndEditing(textField: UITextField) {
        //al activeTextfield le asignamos valor nulo
        self.activeTextField = nil
    }
    
    //se presiono la tecla de retorno en el teclado virtual
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.primerTextField {
            self.segundoTextField.becomeFirstResponder()
        } else if textField == self.segundoTextField {
            self.segundoTextField.resignFirstResponder()
        }
        return true
    }
    

}

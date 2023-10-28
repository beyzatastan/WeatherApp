//
//  ViewController.swift
//  havaDurumu
//
//  Created by beyza nur on 19.10.2023.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var searchText: UITextField!
    
    var sehir=" "
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }

    @IBAction func buttonClicked(_ sender: Any) {
        if searchText.text != "" && searchText.text != " " {
            sehir=searchText.text!

            let feedVC = storyboard?.instantiateViewController(identifier: "DetailsVc") as! DetailsVC
            feedVC.selectedsehir=sehir
            navigationController?.pushViewController(feedVC, animated: true)
    
        } else{
            self.makeAlert(title: "HATA",message: "Şehir girmediniz!")
        }
    }
    
    
    
    @objc func makeAlert(title:String,message:String){
        let alert=UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton=UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true,completion: nil)
        
    }
    
    
}


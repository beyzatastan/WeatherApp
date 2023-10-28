//
//  DetailsVC.swift
//  havaDurumu
//
//  Created by beyza nur on 19.10.2023.
//


// 1-REQUEST & SESSION
// 2-RESPONSE & DATA
// 3-PARSING & JSON SERIALIZATION



import UIKit

class DetailsVC: UIViewController {
    
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dereceLabel: UILabel!
    @IBOutlet weak var ruzgarLabel: UILabel!
    @IBOutlet weak var nemLabel: UILabel!
    @IBOutlet weak var hissedilenLabel: UILabel!
    
    var selectedsehir:String = " "
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityLabel.text=selectedsehir
        
        getData()

        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        
    }
   
    func getData(){
        let url=URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(selectedsehir)&appid=81553a114bc16e43e474d44f39fe09b3")
         let sessinon=URLSession.shared
        
        let task=sessinon.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                self.makeAlert(title: "HATA", message:error!.localizedDescription)
            }else{
                //datayı alabildiysem
                if data != nil{
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary <String,Any>
                        //burdayım
                        DispatchQueue.main.async {
                            if let main = jsonResponse["main"] as? [String:Any]{
                                if let derece=main["temp"] as? Double{
                                    let celsius = Int(derece - 273)
                                   // self.dereceLabel.text=" \(derece)"
                                    self.dereceLabel.text="\(celsius)°C"
                                    
                                    
                                    if let hissedilen=main["feels_like"] as? Double{
                                        let hiss = Int(hissedilen-273)
                                        self.hissedilenLabel.text="Hissedilen: \(hiss)°C"
                                        
                                        if let nem=main["humidity"] as? Double{
                                            self.nemLabel.text="Nem: \(nem) kg/m3"
                                        }
                                
                                    }
                                    
                                }
                                
                            }
                            if let wind=jsonResponse["wind"] as? [String:Any]{
                                if let ruzgar=wind["speed"] as? Double{
                                    self.ruzgarLabel.text="Ruzgar: \(ruzgar)"
                                }
                            }
                    }
                    }catch{
                        self.makeAlert(title: "HATA", message: error.localizedDescription)
                    }
                }
            }
        }
        task.resume()
        
    }

    
    
    func makeAlert(title:String,message:String){
        let alert=UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton=UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true,completion: nil)
        
    }
    
}

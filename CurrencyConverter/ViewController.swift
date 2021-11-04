//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by ysf on 04.11.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chfLabel: UILabel!
  
    @IBOutlet weak var cadLabel: UILabel!
    
    @IBOutlet weak var gbpLabel: UILabel!
    
    @IBOutlet weak var jpyLabel: UILabel!
    
    @IBOutlet weak var usdLabel: UILabel!
    
    @IBOutlet weak var tryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func getRatesClicked(_ sender: Any) {
        
        /*
         api den veri alirken takip edilecek 3 adim var
         1- Request & Session
         2- Response & Data
         3- Parsing & Json Serialization
         */
        
        // 1 .
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=69c449ef90a6fb4c2a76c52d56eedb1d")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
        // 2. info.plist icersinde App Transpoty Security Settings altinda Allow Arbitrary Loads kismini YES yapmamiz gerekiyor
                
                if data != nil {
                    do {
                        let jsonResponse = try  JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        // ASYNC
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String:Any] {
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let tl = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(tl)"
                                }
                            }
                        }
                    } catch {
                        print("error")
                    }
                   
                    
                }
            }
        }
        // tum sistemin calismasi icin bu komutu vermek gerekiyor, baslatiyoruz yani
        
    
        task.resume()
        
        
        
        
    }
    
    
}


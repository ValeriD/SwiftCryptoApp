//
//  AddAccountControllerViewController.swift
//  CryptoMarketApp
//
//  Created by GoStartups Service on 23.11.21.
//

import UIKit

class AddAccountControllerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var addAccountTextField: UITextField!
    
    @IBAction func didTabAddAccount(_ sender: Any) {
        guard let address: String = addAccountTextField.text,
              address != ""
        else{
            return
        }
        RequestManager.fetchAccount(address: address){error, result  in
            if(error == nil){                
                self.navigationController?.popViewController(animated: true)
            }else{
                print(error ?? "")
            }
        }
        
        
    }
}

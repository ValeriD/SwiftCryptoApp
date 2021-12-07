//
//  AccountDetailsViewController.swift
//  CryptoMarketApp
//
//  Created by GoStartups Service on 23.11.21.
//

import UIKit

class AccountDetailsViewController: UIViewController, UITableViewDelegate,
                                        UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var account: Account? = nil {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row{
        case 0:
            guard let headingCell = tableView.dequeueReusableCell(withIdentifier: "headingCell") as? HeadingTableViewCell
            else{
                return UITableViewCell()
            }
            
            headingCell.headingLabel.text = account?.address
            headingCell.subheadingLabel.text = ""
            headingCell.selectionStyle = .none
            headingCell.headingLabel.lineBreakMode = .byTruncatingMiddle
            
            return headingCell
        case 1:
            guard let dataCell = tableView.dequeueReusableCell(withIdentifier: "dataCell")
                    as? DataTableViewCell
            else{
                return UITableViewCell()
            }
            dataCell.backView.backgroundColor = UIColor.systemGray6
            dataCell.iconHolderView.backgroundColor = UIColor.systemRed
            dataCell.imageViewIcon.image = UIImage(systemName: "coloncurrencysign.circle.fill")
            dataCell.imageViewIcon.tintColor = UIColor.white
            dataCell.fieldLabel.textColor = UIColor.black
            dataCell.dataLabel.textColor = UIColor.black
            dataCell.dataLabel.alpha = 0.8
            
            dataCell.fieldLabel.text = "Balance"
            dataCell.dataLabel.text = String(format: "%.2f", account?.final_balance ?? 0.0) + " ETH"
            
            return dataCell
        case 2:
            guard let dataCell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as? DataTableViewCell
            else{
                return UITableViewCell()
            }
            dataCell.backView.backgroundColor = UIColor.systemGray6
            dataCell.iconHolderView.backgroundColor = UIColor.systemGreen
            dataCell.imageViewIcon.image = UIImage(systemName: "coloncurrencysign.circle")
            dataCell.imageViewIcon.tintColor = UIColor.white
            dataCell.fieldLabel.textColor = UIColor.black
            dataCell.dataLabel.textColor = UIColor.black
            dataCell.dataLabel.alpha = 0.8
            
            dataCell.fieldLabel.text = "Unconfirmed balance"
            dataCell.dataLabel.text = String(format: "%.2f", account?.unconfirmed_balance ?? 0.0) + " ETH"
            return dataCell
        case 3:
            guard let dataCell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as? DataTableViewCell
            else{
                return UITableViewCell()
            }
            dataCell.backView.backgroundColor = UIColor.systemGray6
            dataCell.iconHolderView.backgroundColor = UIColor.systemIndigo
            dataCell.imageViewIcon.image = UIImage(systemName:  "coloncurrencysign.circle")
            dataCell.imageViewIcon.tintColor = UIColor.white
            dataCell.fieldLabel.textColor = UIColor.black
            dataCell.dataLabel.textColor = UIColor.black
            dataCell.dataLabel.alpha = 0.8
            
            dataCell.fieldLabel.text = "Transactions"
            dataCell.dataLabel.setFormatedNumber(num: account?.number_of_transactions)
            
            return dataCell
        default:
            return UITableViewCell()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none

    }
    
    override func viewWillAppear(_ animated: Bool) {
        RequestManager.fetchAccount(address: self.account?.address ?? ""){
            error, result in
            if result != nil{
                self.account = result
            }else{
                self.account = AccountService.getAccount(address: self.account?.address ?? "").first
            }
        }
        
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

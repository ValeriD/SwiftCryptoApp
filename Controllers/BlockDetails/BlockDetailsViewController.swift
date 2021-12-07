//
//  BlockDetailsViewController.swift
//  CryptoMarketApp
//
//  Created by GoStartups Service on 3.12.21.
//

import UIKit

class BlockDetailsViewController: ViewController,
                                    UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var block: Block? = nil {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            guard let headingCell = self.tableView.dequeueReusableCell(withIdentifier: "headingCell") as? HeadingTableViewCell
            else{
                return UITableViewCell()
            }
            headingCell.headingLabel.text = block?.blockHash
            headingCell.subheadingLabel.setFormatedNumber(num: self.block?.blockHeight)
            
            headingCell.headingLabel.lineBreakMode = .byTruncatingMiddle
            
            return headingCell
        case 1:
            guard let dataCell = self.tableView.dequeueReusableCell(withIdentifier: "dataCell") as? DataTableViewCell
            else{
                return UITableViewCell()
            }
            
            
            dataCell.imageViewIcon.tintColor = UIColor.white
            dataCell.iconHolderView.backgroundColor = UIColor.red
            dataCell.backView.backgroundColor = UIColor.systemGray6
            dataCell.fieldLabel.textColor = UIColor.black
            dataCell.dataLabel.textColor = UIColor.black

            
            dataCell.fieldLabel.text = "Time"
            dataCell.dataLabel.text = self.block?.blockTime
            return dataCell
        case 2:
            guard let dataCell = self.tableView.dequeueReusableCell(withIdentifier: "dataCell") as? DataTableViewCell
            else{
                return UITableViewCell()
            }
            
            
            dataCell.imageViewIcon.tintColor = UIColor.white
            dataCell.iconHolderView.backgroundColor = UIColor.systemGreen
            dataCell.backView.backgroundColor = UIColor.systemGray6
            dataCell.fieldLabel.textColor = UIColor.black
            dataCell.dataLabel.textColor = UIColor.black

            
            dataCell.fieldLabel.text = "Confirmations"
            dataCell.dataLabel.setFormatedNumber(num: block?.blockConfirmations)
            return dataCell
       
        case 3:
            guard let dataCell = self.tableView.dequeueReusableCell(withIdentifier: "dataCell") as? DataTableViewCell
            else{
                return UITableViewCell()
            }
            
            
            dataCell.imageViewIcon.tintColor = UIColor.white
            dataCell.iconHolderView.backgroundColor = UIColor.systemIndigo
            dataCell.backView.backgroundColor = UIColor.systemGray6
            dataCell.fieldLabel.textColor = UIColor.black
            dataCell.dataLabel.textColor = UIColor.black

            
            dataCell.fieldLabel.text = "Number of transactions"
            dataCell.dataLabel.setFormatedNumber(num: block?.blockNumberTxs)
            return dataCell
       
        case 4:
            guard let dataCell = self.tableView.dequeueReusableCell(withIdentifier: "dataCell") as? DataTableViewCell
            else{
                return UITableViewCell()
            }
            
            
            dataCell.imageViewIcon.tintColor = UIColor.white
            dataCell.iconHolderView.backgroundColor = UIColor.systemOrange
            dataCell.backView.backgroundColor = UIColor.systemGray6
            dataCell.fieldLabel.textColor = UIColor.black
            dataCell.dataLabel.textColor = UIColor.black

            
            dataCell.fieldLabel.text = "Nonce"
            dataCell.dataLabel.text = self.block?.blockNonce
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

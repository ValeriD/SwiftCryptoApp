//
//  StatusViewCellViewController.swift
//  CryptoMarketApp
//
//  Created by GoStartups Service on 24.11.21.
//

import UIKit

class StatusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    // MARK: - TableViewSetup
    @IBOutlet weak var tableView: UITableView!
    var status: BlockchainStatus? = nil{
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
            guard let headingCell = tableView.dequeueReusableCell(withIdentifier: "headingCell") as? HeadingTableViewCell
            else{
                return UITableViewCell()
            }
                
            headingCell.headingLabel.text = self.status?.name
            headingCell.subheadingLabel.text = self.status?.chain
            headingCell.selectionStyle = .none

            return headingCell
        case 1:
            guard let dataCell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as? DataTableViewCell
            else{
                return UITableViewCell()
            }
            dataCell.backView.backgroundColor = UIColor.systemRed
            dataCell.imageViewIcon.tintColor = UIColor.systemRed
            dataCell.imageViewIcon.image = UIImage(systemName: "info.circle")
            dataCell.fieldLabel.text = "Last block"
            dataCell.dataLabel.setFormatedNumber(num: self.status?.lastBlock)
            
            return dataCell
        case 2:
            guard let dataCell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as? DataTableViewCell
            else{
                let dataCell = UITableViewCell()
                dataCell.selectionStyle = .none
                return dataCell
            }
            dataCell.backView.backgroundColor = UIColor.systemGreen
            dataCell.imageViewIcon.tintColor = UIColor.systemGreen
            dataCell.imageViewIcon.image = UIImage(systemName: "info.circle")
            dataCell.fieldLabel.text = "Last block hash"
            dataCell.dataLabel.text = self.status?.lastBlockHash
            dataCell.dataLabel.lineBreakMode = .byTruncatingMiddle
            return dataCell
            
        case 3:
            guard let dataCell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as? DataTableViewCell
            else{
                return UITableViewCell()
            }
            
            dataCell.backView.backgroundColor = UIColor.systemIndigo
            dataCell.imageViewIcon.tintColor = UIColor.systemIndigo
            dataCell.imageViewIcon.image = UIImage(systemName: "info.circle")
            dataCell.fieldLabel.text = "Last block time"
            dataCell.dataLabel.text = self.status?.lastBlockTime
            dataCell.selectionStyle = .none

            return dataCell
        case 4:
            guard let dataCell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as? DataTableViewCell
            else{
                return UITableViewCell()
            }
            dataCell.backView.backgroundColor = UIColor.systemOrange
            dataCell.imageViewIcon.tintColor = UIColor.systemOrange
            dataCell.imageViewIcon.image = UIImage(systemName:  "info.circle")
            dataCell.fieldLabel.text = "Difficulty"
            dataCell.dataLabel.setFormatedNumber(num: self.status?.difficulty)
            dataCell.selectionStyle = .none
            return dataCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row == 1 || indexPath.row == 2 {
            guard let blockDetailsView = UIStoryboard(name: "Main", bundle: nil) .instantiateViewController(withIdentifier: "BlockDetailsViewController") as? BlockDetailsViewController,
                  let height = status?.lastBlock
            else{
                return
            }
            RequestManager.fetchLastBlock(height: height){
                error,result in
                
                if error != nil{
                    return
                }
                blockDetailsView.loadViewIfNeeded()
                if result != nil{
                    blockDetailsView.block = result
                   
                }else{
                    blockDetailsView.block = BlockService.getLatestBlock()
                }
                if blockDetailsView.block != nil{
                    blockDetailsView.loadViewIfNeeded()
                    
                    self.navigationController?.pushViewController(blockDetailsView, animated: true)
                }
            }
        }
    }
    
    // MARK: - Screen setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        RequestManager.fetchBlockchainStatus(){
            error, response in
            if response != nil{
                self.status = response
            }else{
                self.status = BlockchainStatusService.getBlockchainStatus(blockchainName: "Ethereum").first
            }
        }
    }

    // MARK: - Navigation
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(f
     or segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

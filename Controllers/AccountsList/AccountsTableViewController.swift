//
//  AccountsTableViewController.swift
//  CryptoMarketApp
//
//  Created by GoStartups Service on 22.11.21.
//

import UIKit

class AccountsTableViewController: UITableViewController {
    var data: [Account] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        self.tableView.reloadData()
    }
    func loadData(){
        self.data.removeAll()
        self.data.append(contentsOf: AccountService.getAccounts())
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "accountsTableViewCell", for: indexPath) as? AccountsTableViewCell
        else{
            return UITableViewCell();
        }

        // Configure the cell...
        cell.accountAddress?.text = data[indexPath.row].address
        cell.accountBalance?.text = String(format: "%.2f", data[indexPath.row].final_balance) + " ETH"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Redirect to details
        
        guard let accountDetailsView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountDetailsViewController") as? AccountDetailsViewController
        else{
            return
        }
        accountDetailsView.loadViewIfNeeded()
        accountDetailsView.account = data[indexPath.row]
        
        self.navigationController?.pushViewController(accountDetailsView, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    */

}

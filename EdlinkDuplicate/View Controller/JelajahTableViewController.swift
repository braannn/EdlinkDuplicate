//
//  JelajahTableViewController.swift
//  EdlinkDuplicate
//
//  Created by Muhammad Syabran on 10/01/21.
//

import UIKit

class JelajahTableViewController: UITableViewController,UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let data = ["Animasi 2d","Teknik layanan jaringan","bahasa zimbabwe","tugas gambar arsitektur"]
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        filteredData = data
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jelajah")! as UITableViewCell
        
            cell.textLabel?.text = data[indexPath.row]
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        // untuk table view tidak kosong meskipun tidak ada text dalam search bar
        if searchText == "" {
            filteredData = data
        }
        else {
            for tugas in data {
            
            if tugas.lowercased().contains(searchText.lowercased()) {
               filteredData.append(tugas)
                }
            }
        }
        self.tableView.reloadData()
    }
    // for hide keyboard by touch view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // for hide keyboard by return
    private func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return (true)
    }
}

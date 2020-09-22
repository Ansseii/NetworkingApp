//
//  MainTableViewController.swift
//  NetworkingApp
//
//  Created by Aleksandr on 22.09.2020.
//

import UIKit

class MainTableViewController: UITableViewController {
  
  private let charactersUrl = "https://www.breakingbadapi.com/api/characters"
  private var characters: [Character]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NetworkManager.instance.fetchData(jsonUrl: charactersUrl,
                                      type: [Character].self) { characters in
      DispatchQueue.main.async {
        self.characters = characters
        self.tableView.reloadData()
      }
    }
  }
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    characters?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell",
                                             for: indexPath)
    cell.textLabel?.text = characters?[indexPath.row].name
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "moveToSummary", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let currentIndexPath =
            tableView.indexPathForSelectedRow else { return }
    guard let summaryVC =
            segue.destination as? SummaryViewController else { return }
    summaryVC.character = characters?[currentIndexPath.row]
  }
}

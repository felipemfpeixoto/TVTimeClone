//
//  ShowsView.swift
//  Challenge6TVTime
//
//  Created by Ana Zacour on 11/02/25.
//

import UIKit

class ShowsViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var shows: [TVShow] = TVShowsManager.shared.watchedTvShow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(YourShowsCellTableView.nib(), forCellReuseIdentifier: YourShowsCellTableView.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
}

extension ShowsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YourShowsCellTableView.identifier, for: indexPath) as! YourShowsCellTableView
        
        cell.configure(with: shows[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension ShowsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("Selecionou: \(shows[indexPath.row].name)")
        
        performSegue(withIdentifier: "showDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        
        let destinationViewController = segue.destination as! DescriptionShowsView
        destinationViewController.tvShow = shows[selectedIndexPath.row]
    }
}


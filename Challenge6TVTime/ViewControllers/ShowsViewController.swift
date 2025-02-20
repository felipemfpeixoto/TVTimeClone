//
//  ShowsView.swift
//  Challenge6TVTime
//
//  Created by Ana Zacour on 11/02/25.
//

import UIKit

class ShowsViewController: UIViewController {

    @IBOutlet weak var navigationTopItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    var shows: [TVShow] = TVShowsManager.shared.planningTvShow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(YourShowsCellTableView.nib(), forCellReuseIdentifier: YourShowsCellTableView.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLayoutSubviews() {
        
        self.tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 32, right: 0)
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.shows = TVShowsManager.shared.planningTvShow
        
        tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
}

extension ShowsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("Selecionou: \(shows[indexPath.row].name)")
        
        performSegue(withIdentifier: "showDetailSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue",
            let destinationViewController = segue.destination as? DescriptionShowsViewController,
            let indexPath = sender as? IndexPath {
                destinationViewController.tvShow = shows[indexPath.row]
            }
    }
}

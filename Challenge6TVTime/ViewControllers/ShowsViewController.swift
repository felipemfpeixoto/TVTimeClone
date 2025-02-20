//
//  ShowsView.swift
//  Challenge6TVTime
//
//  Created by Ana Zacour on 11/02/25.
//

import UIKit

class ShowsViewController: UIViewController, YourShowsCellTableViewDelegate {
    func didTapButton(in cell: YourShowsCellTableView) {
        print("chamou")
        
        let alert = UIAlertController(title: "Watched TV Show", message: "Are you sure you want do add \(cell.tvShow!.name) to your watched list?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            TVShowsManager.shared.removePlanned(cell.tvShow!)
            TVShowsManager.shared.addWatched(cell.tvShow!)
            
            self.shows.remove(at: self.shows.firstIndex(of: cell.tvShow!)!)
            self.tableView.reloadData()
        }))
        
        present(alert, animated: true)
    }
    

    @IBOutlet weak var navigationTopItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    var shows: [TVShow] = TVShowsManager.shared.planningTvShow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(YourShowsCellTableView.nib(), forCellReuseIdentifier: YourShowsCellTableView.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        tableView.separatorStyle = .none // Remove linha padrão entre células
    }
    
    override func viewDidLayoutSubviews() {
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
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150 // Altura fixa da célula
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20 // Espaçamento fixo entre células
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

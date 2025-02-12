//
//  ViewController.swift
//  Challenge6TVTime
//
//  Created by Ana Zacour on 05/02/25.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    

    @IBOutlet var SelectShows: UIView!
    
    @IBOutlet weak var posterCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "PosterCellCollectionView", bundle: nil), forCellWithReuseIdentifier: "PosterCellCollectionView")
        // Do any additional setup after loading the view.
    }


}


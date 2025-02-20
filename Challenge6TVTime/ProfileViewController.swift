//
//  ProfileView.swift
//  Challenge6TVTime
//
//  Created by Ana Zacour on 11/02/25.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var watchlist: [TVShow] = Welcome.loadFromBundle()?.results ?? []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
    }
    
    // MARK: - Setup Methods
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        
        collectionView.register(PosterCellCollectionView.nib(), forCellWithReuseIdentifier: PosterCellCollectionView.identifier)
        
        collectionView.register(PosterCellCollectionView.nib(), forCellWithReuseIdentifier: PosterCellCollectionView.identifier)
    }
    
    // MARK: - Layout Methods
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return self.createHorizontalSection(groupWidth: 0.45, groupHeight: 189)
            case 1:
                return self.createHorizontalSection(groupWidth: 0.25, groupHeight: 189)
            default:
                return nil
            }
        }
    }
    
    private func createHorizontalSection(groupWidth: CGFloat, groupHeight: CGFloat) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupWidth), heightDimension: .estimated(groupHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return watchlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCellCollectionView.identifier, for: indexPath) as! PosterCellCollectionView
            
            cell.configure(with: watchlist[indexPath.row])
            
            return cell
        
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCellCollectionView.identifier, for: indexPath) as! PosterCellCollectionView
            
            cell.configure(with: watchlist[indexPath.row])
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: Lets us determine what is the margin and padding between each cell
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 112, height: 189)
    }
}


//import UIKit
//
//class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
//    
//    // MARK: - Outlets
//    @IBOutlet weak var saldo: UILabel!
//    @IBOutlet weak var hideSaldoButton: UIButton!
//    @IBOutlet weak var collectionView: UICollectionView!
//    
//    // MARK: - Properties
//    var person: PersonClass!
//    var isSaldoHidden: Bool = false
//    let firstSectionItems = ["Um", "Dois", "Três", "Quatro", "Cinco"]
//    let secondSectionItems = ["Seis", "Sete", "Oito", "Nove", "Dez"]
//    let thirdSectionItems = ["Acer", "Americanas", "Dell", "Imaginarium", "Nespresso", "Shoptime", "Submarino"]
//    
//    // MARK: - Lifecycle Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        saldo.text = formatCurrency(person.money)
//        setupCollectionView()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//    }
//    
//    // MARK: - Setup Methods
//    private func setupCollectionView() {
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.setCollectionViewLayout(createLayout(), animated: false)
//        
//        collectionView.register(CollectionViewHeader.self,
//                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//                                withReuseIdentifier: "header")
//        collectionView.register(UINib(nibName: "OfertasCollectionViewCell", bundle: nil),  forCellWithReuseIdentifier: "OfertasCollectionViewCell")
//        collectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil),  forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
//        collectionView.register(UINib(nibName: "CashbackCollectionViewCell", bundle: nil),  forCellWithReuseIdentifier: "CashbackCollectionViewCell")
//    }
//    
//    // MARK: - Actions
//    @IBAction func hideSaldo(_ sender: UIButton) {
//        isSaldoHidden.toggle()
//        hideSaldoButton.setImage(UIImage(systemName: isSaldoHidden ? "eye.slash" : "eye"), for: .normal)
//        saldo.text = isSaldoHidden ? "R$ *****" : formatCurrency(person.money)
//    }
//    
//    // MARK: - Helper Methods
//    private func formatCurrency(_ amount: Double) -> String {
//        return String(format: "R$ %.2f", amount)
//    }
//    
//    // MARK: - UICollectionViewDataSource Methods
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 3
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0: return firstSectionItems.count
//        case 1: return secondSectionItems.count
//        case 2: return thirdSectionItems.count
//        default: return 0
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch indexPath.section {
//        case 0:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfertasCollectionViewCell", for: indexPath) as? OfertasCollectionViewCell else {
//                fatalError("Could not dequeue OfertasCollectionViewCell")
//            }
//            cell.ofertaImage.image = UIImage(systemName: "house")
//            cell.ofertaLabel.text = "Ofertas"
//            return cell
//        
//        case 1:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as? CategoriesCollectionViewCell else {
//                fatalError("Could not dequeue CategoriesCollectionViewCell")
//            }
//            cell.categoryImage.image = UIImage(systemName: "house")
//            cell.categoryName.text = "Categoria"
//            return cell
//        
//        case 2:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CashbackCollectionViewCell", for: indexPath) as? CashbackCollectionViewCell else {
//                fatalError("Could not dequeue CashbackCollectionViewCell")
//            }
//            cell.shopImage.image = UIImage(named: thirdSectionItems[indexPath.item])
//            cell.shopName.text = thirdSectionItems[indexPath.item]
//            cell.cashbackAmount.text = "10% cashback"
//            return cell
//        
//        default:
//            return UICollectionViewCell()
//        }
//    }
//    
//    // MARK: - Layout Methods
//    private func createLayout() -> UICollectionViewCompositionalLayout {
//        return UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
//            switch sectionIndex {
//            case 0:
//                return self.createHorizontalSection(groupWidth: 0.45, groupHeight: 80)
//            case 1:
//                return self.createHorizontalSection(groupWidth: 0.25, groupHeight: 130)
//            case 2:
//                return self.createHorizontalSection(groupWidth: 0.25, groupHeight: 150)
//            default:
//                return nil
//            }
//        }
//    }
//    
//    private func createHorizontalSection(groupWidth: CGFloat, groupHeight: CGFloat) -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupWidth), heightDimension: .estimated(groupHeight))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        section.interGroupSpacing = 10
//        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//        
//        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
//        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//        
//        section.boundarySupplementaryItems = [sectionHeader]
//        
//        return section
//    }
//    
//    // MARK: - UICollectionViewDelegate Methods
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard kind == UICollectionView.elementKindSectionHeader else {
//            return UICollectionReusableView()
//        }
//        
//        guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? CollectionViewHeader else {
//            fatalError("Could not dequeue SectionHeader")
//        }
//        
//        let sectionTitles = ["Ofertas", "Navegue por categorias", "Especiais para você"]
//        sectionHeader.label.text = sectionTitles[indexPath.section]
//        return sectionHeader
//    }
//}

//
//  ProfileView.swift
//  Challenge6TVTime
//
//  Created by Ana Zacour on 11/02/25.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var watchedlist: [TVShow] = TVShowsManager.shared.planningTvShow
    
    var watchlist: [TVShow] = TVShowsManager.shared.watchedTvShow
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    // MARK: - Setup Methods
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        
        // Registro da célula
        collectionView.register(PosterCellCollectionView.nib(), forCellWithReuseIdentifier: PosterCellCollectionView.identifier)
        
        // Registro do cabeçalho da seção
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
    }
    
    // MARK: - Layout Methods
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return self.createHorizontalSection(groupWidth: 0.3, groupHeight: 189)
            case 1:
                return self.createHorizontalSection(groupWidth: 0.3, groupHeight: 189)
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
        section.interGroupSpacing = 10  // Ajustável conforme necessário
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.watchedlist = TVShowsManager.shared.planningTvShow
        
        self.watchlist = TVShowsManager.shared.watchedTvShow
        
        collectionView.reloadData()
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0:
                return TVShowsManager.shared.watchedTvShow.count
            case 1:
                return TVShowsManager.shared.planningTvShow.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCellCollectionView.identifier, for: indexPath) as! PosterCellCollectionView
        
        var usedArray: [TVShow] = []
        
        switch indexPath.section {
            case 0:
            usedArray = TVShowsManager.shared.watchedTvShow
            case 1:
            usedArray = TVShowsManager.shared.planningTvShow
            default:
                return cell
        }
        
        cell.configure(with: usedArray[indexPath.row])
        return cell
    }
    
    // Configuração do cabeçalho da seção
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
        
        switch indexPath.section {
        case 0:
            header.titleLabel.text = "Watched TV Shows"
        case 1:
            header.titleLabel.text = "My Watch List"
        default:
            header.titleLabel.text = "Default"
        }
        
        return header
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 112, height: 50)
    }
}

// MARK: - Cabeçalho da Seção
class SectionHeaderView: UICollectionReusableView {
    
    static let identifier = "SectionHeaderView"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

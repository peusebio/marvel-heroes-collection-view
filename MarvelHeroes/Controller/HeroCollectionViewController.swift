//
//  ViewController.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 15/10/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import UIKit

class HeroCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, HeroViewControllerDelegate  {
    
    weak var coordinator: MainCoordinator?
    
    private let cellId = "cellId"
    
    private var selectedCellIndexPath: IndexPath?
    
    private var viewModel: HeroListViewModel!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let requestLimit: Int = 50
    
    private var cells: [HeroCell] = []
    
    init(collectionViewLayout: UICollectionViewFlowLayout) {
        super.init(collectionViewLayout: collectionViewLayout)
        
        if let layout = collectionViewLayout as? HeroCollectionViewFlowLayout {
            layout.delegate = self
        }
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionViewLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        
        let request = HeroListRequest.with(limit: requestLimit)
        viewModel = HeroListViewModel(request: request, delegate: self, limit: requestLimit)
        
        viewModel.fetchCharacters()
        viewModel.loadFavorites()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        collectionView.isHidden = false
        
        collectionView.register(HeroCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = false
        
        /*Search*/
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a Hero"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
    }
    
    //reloads a cell that has been previously selected to handle changes on the isFavorite flag of a hero
    override func viewWillAppear(_ animated: Bool) {
        if let indexPath = selectedCellIndexPath {
            collectionView.reloadItems(at: [indexPath])
        }
        
        //let layout = HeroCollectionViewFlowLayout()
    }
}

extension HeroCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            perform(#selector(search), with: searchText, afterDelay: 0.5)
        } else {
            viewModel.reset()
            if collectionView.numberOfItems(inSection: 0) != 0 {
                collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
            viewModel.fetchCharacters()
            collectionView.reloadData()
        }
    }
    
    @objc func search(searchText: String){
        viewModel.prepareSearch(searchText: searchText)
        if collectionView.numberOfItems(inSection: 0) != 0 {
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
        viewModel.fetchCharacters()
        collectionView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            
            if searchText.isEmpty {
                viewModel.reset()
                if collectionView.numberOfItems(inSection: 0) != 0 {
                    collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                }
                viewModel.fetchCharacters()
                collectionView.reloadData()
            }
        }
    }
    
    func addToFavorites(id: Int) {
        viewModel.favorites.append(id)
        viewModel.saveFavorites()
    }
    
    func removeFromFavorites(id: Int) {
        if let index = viewModel.favorites.firstIndex(of: id) {
            viewModel.favorites.remove(at: index)
        }
        viewModel.saveFavorites()
    }
}

extension HeroCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        viewModel.totalCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        print(indexPath.item)
        //        return cells[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HeroCell

        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none, isFavorite: false)
        } else {
            let hero = viewModel.hero(at: indexPath.item)
            let isFavorite = viewModel.isFavorite(heroId: hero.id)
            cell.configure(with: hero, isFavorite: isFavorite)
            if let thumbnailData = viewModel.heroThumbnailsData[hero.id] {
                cell.addThumbnail(thumbnailData: thumbnailData)
            } else {
                viewModel.loadHeroThumbnail(heroIndex: indexPath.item)
            }
        }
        
        cell.contentView.setNeedsLayout()
        cell.contentView.layoutIfNeeded()
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCellIndexPath = indexPath
        let heroAtIndexPath = viewModel.hero(at: indexPath.item)
        let isFavorite = viewModel.isFavorite(heroId: heroAtIndexPath.id)
        
        coordinator?.showHeroDetails(hero: heroAtIndexPath, delegate: self, favorite: isFavorite, nibName: nil, bundle: nil)
    }
}

extension HeroCollectionViewController: HeroListViewModelDelegate{
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        DispatchQueue.main.async {
            // 1
            guard let newIndexPathsToReload = newIndexPathsToReload else {
                //                self.indicatorView.stopAnimating()
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
                return
            }
            // 2
            let indexPathsToReload = self.visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
            self.collectionView.reloadItems(at: indexPathsToReload)
        }
    }
    
    func onFetchFailed(with reason: String) {
        print("Something went wrong when getting character information from the server")
        //        indicatorView.stopAnimating()
        
        //        let title = "Warning".localizedString
        //        let action = UIAlertAction(title: "OK".localizedString, style: .default)
        //        displayAlert(with: title , message: reason, actions: [action])
    }
    
    func addThumbnailToCell(cellItemIndex: Int, thumbnailData: Data) {
        let indexPath = IndexPath(item: cellItemIndex, section: 0)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? HeroCell {
            cell.addThumbnail(thumbnailData: thumbnailData)
        }
    }
}

extension HeroCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchCharacters()
            //loadCells()
        }
    }
}

private extension HeroCollectionViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.item >= viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleItems = collectionView.indexPathsForVisibleItems
        let indexPathsIntersection = Set(indexPathsForVisibleItems).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

extension HeroCollectionViewController: HeroCollectionViewFlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForHeroCellAtIndexPath indexPath: IndexPath) -> CGFloat {
//        if !cells.isEmpty && indexPath.item<requestLimit {
//            return cells[indexPath.item].bounds.height
//        }
        
//        let cell = HeroCell()
//
//        do {
//            let hero = try viewModel.hero(at: indexPath.item)
//            cell.configure(with: hero, isFavorite: false)
//            return cell.bounds.height
//        } catch {
//            return 100
//        }
        return 100
    }
    
    func reload(){
        self.collectionView.reloadData()
    }
}

protocol HeroViewControllerDelegate {
    func addToFavorites(id: Int)
    func removeFromFavorites(id: Int)
}

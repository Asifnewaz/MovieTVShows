//
//  SearchViewController.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import UIKit
import RxSwift
import RxCocoa


class SearchViewController: UIViewController {
   
    @IBOutlet weak var searchTableView: UITableView!
    
    let search = UISearchController(searchResultsController: nil)
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect.zero)
    
    let rightBarButton = UIBarButtonItem()
    let btnName = UIButton()
    var searchFor: String = "Movies" {
        didSet {
            btnName.setTitle(searchFor, for: .normal)
            btnName.setTitleColor(UIColor.systemBlue, for: .normal)
            btnName.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
            searchBar.placeholder = "Search \(searchFor)"
            search.searchBar.placeholder = "Search \(searchFor)"
        }
    }
    
    var searchCoordinator: SearchCoordinator?
    var viewModel: SearchListViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        setupUI()
        setupBindings()
    }

    private func setupUI() {
        searchBar.placeholder = "Search movies"
        search.searchBar.placeholder = "Search movies"
        
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = search
        } else {
            navigationItem.titleView = searchBar
        }
        
        self.searchFor = "Movies"
        rightBarButton.customView = btnName
        self.navigationItem.rightBarButtonItem = rightBarButton
        btnName.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    @objc func buttonTapped(sender: UIBarButtonItem!) {
        let alert = UIAlertController(title: "Select", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Movies", style: .default , handler:{ (UIAlertAction)in
            self.searchFor = "Movies"
        }))
        alert.addAction(UIAlertAction(title: "Tv Shows", style: .default , handler:{ (UIAlertAction)in
            self.searchFor = "Tv Shows"
        }))
        //uncomment for iPad Support
        alert.popoverPresentationController?.sourceView = self.view
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupBindings() {
        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)

        if self.searchFor.lowercased() == "movies" {
            let results = search.searchBar.rx.text.orEmpty
                .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
                .distinctUntilChanged()
                .flatMapLatest { query -> Observable<[Movie]> in
                  if query.isEmpty {
                    return .just([])
                  }
                    return APIService().searchMovies(searchString: query)
                      .catch { error in
                          return .just([])
                      }
                }
                .observe(on: MainScheduler.instance)

              results
                .bind(to: searchTableView.rx.items(cellIdentifier: "SearchTableViewCell", cellType: SearchTableViewCell.self)) { [weak self] (_, info, cell) in
                    cell.mvi = info
                    self?.setupSearchCell(cell, info: info)
                }
                .disposed(by: disposeBag)
        } else {
            let results = search.searchBar.rx.text.orEmpty
                .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
                .distinctUntilChanged()
                .flatMapLatest { query -> Observable<[TVShow]> in
                  if query.isEmpty {
                    return .just([])
                  }
                    return APIService().searchTvShows(searchString: query)
                      .catch { error in
                          return .just([])
                      }
                }
                .observe(on: MainScheduler.instance)

              results
                .bind(to: searchTableView.rx.items(cellIdentifier: "SearchTableViewCell", cellType: SearchTableViewCell.self)) { [weak self] (_, info, cell) in
                    cell.setName(info.name ?? "")
                    cell.show = info
                }
                .disposed(by: disposeBag)
        }
    }
    
    func setupSearchCell(_ cell: SearchTableViewCell, info: Movie) {
        cell.setName(info.title ?? "")
    }
}


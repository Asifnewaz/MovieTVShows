//
//  MovieListController.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListController: UIViewController {
    
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    
    var movieListCoordinator: MovieListCoordinator?
    var viewModel: MovieListViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        setupBindings()
    }

    private func setupUI() {
        movieListCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func setupBindings() {

        viewModel.movies
            .observe(on: MainScheduler.instance)
            .bind(to: movieListCollectionView.rx.items(cellIdentifier: "MovieCell", cellType: MovieCell.self)) { [weak self] (_, mvi, cell) in
                self?.setupMovieCell(cell, movie: mvi)
            }
            .disposed(by: disposeBag)
        
        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)

        viewModel.alertMessage
            .subscribe(onNext: { [weak self] in self?.presentAlert(message: $0) })
            .disposed(by: disposeBag)
        
        movieListCollectionView.rx.modelSelected(MovieViewModel.self)
            .subscribe ({ (vm) in
                _ = self.movieListCoordinator?.showMovieDetails(vm.element?.movie)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupMovieCell(_ cell: MovieCell, movie: MovieViewModel) {
        cell.setName(movie.fullName ?? "")
        movie.posterPath
            .asObservable()
            .observe(on: MainScheduler.instance)
            .map { $0 }
            .bind(to: cell.image.rx.image)
            .disposed(by:self.disposeBag)
    }

}

extension MovieListController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        var cellWidth = (width - 15) / 2
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            cellWidth = (width - 15) / 2
        case .pad:
            cellWidth = (width - 25) / 3
        @unknown default:
            break
        }
        let cellHeight = cellWidth / 0.8
        return CGSize(width: cellWidth, height: cellHeight)
    }
}


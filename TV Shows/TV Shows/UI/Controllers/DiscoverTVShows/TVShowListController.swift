//
//  TVShowListController.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import UIKit
import RxSwift
import RxCocoa

class TVShowListController: UIViewController {
    
    @IBOutlet weak var tvShowsCollectionView: UICollectionView!
    
    var tvShowListCoordinator: TVShowListCoordinator?
    var viewModel: TVShowListViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        setupBindings()
    }

    private func setupUI() {
        tvShowsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func setupBindings() {

        viewModel.tvShows
            .observe(on: MainScheduler.instance)
            .bind(to: tvShowsCollectionView.rx.items(cellIdentifier: "TVShowCell", cellType: TVShowCell.self)) { [weak self] (_, tvShow, cell) in
                self?.setupMovieCell(cell, show: tvShow)
            }
            .disposed(by: disposeBag)
        
        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)

        viewModel.alertMessage
            .subscribe(onNext: { [weak self] in self?.presentAlert(message: $0) })
            .disposed(by: disposeBag)
        
        tvShowsCollectionView.rx.modelSelected(TVShowViewModel.self)
            .subscribe ({ (vm) in
                _ = self.tvShowListCoordinator?.showTVShowsDetails(vm.element?.tvShow)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupMovieCell(_ cell: TVShowCell, show: TVShowViewModel) {
        cell.setName(show.fullName ?? "")
//        cell.setDescription(show.description ?? "")
        show.posterPath
            .asObservable()
            .observe(on: MainScheduler.instance)
            .map { $0 }
            .bind(to: cell.image.rx.image)
            .disposed(by:self.disposeBag)
    }
    
}

extension TVShowListController:UICollectionViewDelegateFlowLayout {
    
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

class TVShowCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func setName(_ fullName: String) {
        name.text = fullName
    }

    func setDescription(_ description: String) {
        image.image = UIImage(named: "movieTvDummy")
    }
}

//
//  MovieDetailsViewController.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import UIKit
import RxSwift

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var tagLine: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    var viewModel: MovieDetailsViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }
    
    
    private func setupBindings() {
        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)

        self.viewModel.tagLine
          .asObservable()
          .map { $0 }
          .bind(to:self.tagLine.rx.text)
          .disposed(by:self.disposeBag)
        
        self.viewModel.genres
          .asObservable()
          .map { $0 }
          .bind(to:self.genres.rx.text)
          .disposed(by:self.disposeBag)
        
        self.viewModel.overView
          .asObservable()
          .map { $0 }
          .bind(to:self.overview.rx.text)
          .disposed(by:self.disposeBag)
        
        self.viewModel.popularity
          .asObservable()
          .map { $0 }
          .bind(to:self.popularity.rx.text)
          .disposed(by:self.disposeBag)
        
        self.viewModel.posterPath
          .asObservable()
          .map { $0 }
          .bind(to:self.posterImage.rx.image)
          .disposed(by:self.disposeBag)
        
        
        viewModel.alertMessage
            .subscribe(onNext: { [weak self] in self?.presentAlert(message: $0) })
            .disposed(by: disposeBag)
        
    }
}

//
//  InfoCell.swift
//  MVVM-RXSwift
//
//  Created by Nitkarsh Gupta on 27/09/20.
//

import UIKit
import SDWebImage
import RxCocoa
import RxSwift

class InfoCell: UITableViewCell {

    static let identifier = "InfoCell"
    static let nib = UINib(nibName: "InfoCell", bundle: nil)
    
    @IBOutlet private weak var sampleImage: UIImageView! {
        didSet {
            sampleImage.image = UIImage()
            sampleImage.backgroundColor = .clear
            sampleImage.alpha = 0.2
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    @IBOutlet private weak var authorLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ article: InfoVM) {
        
        article.title.asDriver(onErrorJustReturn: nil)
            .drive(self.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        article.description.asDriver(onErrorJustReturn: nil)
            .drive(self.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        article.author.asDriver(onErrorJustReturn: nil)
            .drive(self.authorLabel.rx.text)
            .disposed(by: disposeBag)
        
        article.imageURL.observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] url in
                self?.sampleImage.sd_setImage(with: url)
            })
            .disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.sampleImage.image = UIImage()
        self.titleLabel.text = nil
        self.descriptionLabel.text = nil
        self.authorLabel.text = nil
    }
    
}
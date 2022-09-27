//
//  TitleTableViewCell.swift
//  NetflixClone
//
//  Created by Enes Özkırdeniz on 27.09.2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"
    
    private let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let playButton : UIButton = {
        let btn = UIButton()
        let image = UIImage(systemName: "play.circle" , withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        btn.setImage(image, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .white
        return btn
    }()
    
    private let titlesPosterImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titlesPosterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButton)
        
        constraintAta()
    }
    
    private func constraintAta() {
        let posterImageConstraints = [
            titlesPosterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlesPosterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlesPosterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlesPosterImage.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterImage.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        let buttonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(posterImageConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    public func configure(with model : TitleViewModel) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {return}
                
        titlesPosterImage.sd_setImage(with: url, completed : nil)
        titleLabel.text = model.titleName
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

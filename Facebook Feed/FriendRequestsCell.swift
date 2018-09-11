//
//  FriendRequestsCell.swift
//  Facebook Feed
//
//  Created by Umar Yaqub on 09/09/2018.
//  Copyright © 2018 Umar Yaqub. All rights reserved.
//

import UIKit

class FriendRequestsCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Mark Zuckerberg"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let requestImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "MarkZuck")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.rgb(red: 87, green: 143, blue: 255)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        button.layer.cornerRadius = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(UIColor(white: 0.3, alpha: 1), for: .normal)
        button.layer.cornerRadius = 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(white: 0.7, alpha: 1).cgColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private func setupView() {
        addSubview(nameLabel)
        addSubview(requestImageView)
        
        requestImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        requestImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        requestImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        requestImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: requestImageView.rightAnchor, constant: 5).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: requestImageView.topAnchor).isActive = true
        
        let buttonStackView = UIStackView(arrangedSubviews: [confirmButton, deleteButton])
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 5
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonStackView)
        
        buttonStackView.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        buttonStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3).isActive = true
        buttonStackView.widthAnchor.constraint(equalToConstant: 230).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

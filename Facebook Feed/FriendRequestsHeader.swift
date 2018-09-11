//
//  FriendRequestsHeader.swift
//  Facebook Feed
//
//  Created by Umar Yaqub on 09/09/2018.
//  Copyright © 2018 Umar Yaqub. All rights reserved.
//

import UIKit

class FriendRequestsHeader: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "FRIEND REQUESTS"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(white: 0.4, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 235)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupView() {
        addSubview(nameLabel)
        addSubview(bottomBorderView)
        
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        bottomBorderView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorderView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorderView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorderView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
}

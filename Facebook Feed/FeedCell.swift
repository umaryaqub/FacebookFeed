//
//  FeedCell.swift
//  Facebook Feed
//
//  Created by Umar Yaqub on 05/09/2018.
//  Copyright © 2018 Umar Yaqub. All rights reserved.
//

import UIKit

protocol zoomImageDelegate {
    func didTapImage(imageView: UIImageView)
}

class FeedCell: UICollectionViewCell {
    
    var delegate: zoomImageDelegate?
    @objc private func handleTap() {
        delegate?.didTapImage(imageView: postIV)
    }
    
    var post: Post? {
        didSet {
            setupNameLabel()
            setupPostProperties()
        }
    }
    
    private func setupNameLabel() {
        if let name = post?.name {
            let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
            attributedText.append(NSAttributedString(string: "\nDecember 15 * San Fransisco *  ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.lightGray]))
            
            let paragraphStryle = NSMutableParagraphStyle()
            paragraphStryle.lineSpacing = 4
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStryle, range: NSRange(location: 0, length: attributedText.string.count))
            
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "Globe")
            attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
            attributedText.append(NSAttributedString(attachment: attachment))
            
            nameLabel.attributedText = attributedText
        }
    }
    
    private func setupPostProperties() {
        if let caption = post?.caption {
            captionLabel.text = caption
        }
        if let profileImageName = post?.profileImageName {
            profileIV.image = UIImage(named: profileImageName)
        }
        /*postIV.image = nil
        
        if let postImageUrl = post?.postImageUrl {
            
            let task = URLSession.shared.dataTask(with: URL(string: postImageUrl)!) { (data, resp, err) in
                if let err = err {
                    print(err)
                    return
                }
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.postIV.image = image
                    }
                }
            }
            task.resume()
        }*/
        if let postImageName = post?.postImageUrl {
            self.postIV.image = UIImage(named: postImageName)
        }
        if let likes = post?.likes, let comments = post?.comments {
            likesCommentsLabel.text = "\(likes) Likes \(comments)k Comments"
        }
        
        postIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupButtons()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileIV: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let postIV: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        return iv
    }()
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        return label
    }()
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        button.tintColor = .lightGray
        button.setImage(#imageLiteral(resourceName: "Like").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Comment").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .lightGray
        button.setImage(#imageLiteral(resourceName: "Share").withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func handleLike() {
        print("like")
    }
    
    private func setupView() {
        self.backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(profileIV)
        addSubview(captionLabel)
        addSubview(postIV)
        addSubview(likesCommentsLabel)
        addSubview(dividerLineView)

        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: profileIV.rightAnchor, constant: 5).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        profileIV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        profileIV.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileIV.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profileIV.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        
        captionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        captionLabel.leftAnchor.constraint(equalTo: profileIV.leftAnchor).isActive = true
        captionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        captionLabel.bottomAnchor.constraint(equalTo: postIV.topAnchor, constant: -3).isActive = true
        
        postIV.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        postIV.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        postIV.heightAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        likesCommentsLabel.topAnchor.constraint(equalTo: postIV.bottomAnchor, constant: 5).isActive = true
        likesCommentsLabel.leftAnchor.constraint(equalTo: captionLabel.leftAnchor, constant: 0).isActive = true
        likesCommentsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        likesCommentsLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        dividerLineView.leftAnchor.constraint(equalTo: captionLabel.leftAnchor).isActive = true
        dividerLineView.rightAnchor.constraint(equalTo: captionLabel.rightAnchor).isActive = true
        dividerLineView.topAnchor.constraint(equalTo: likesCommentsLabel.bottomAnchor, constant: 5).isActive = true
        dividerLineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    private func setupButtons() {
        let buttonStackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 50
        addSubview(buttonStackView)
        buttonStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        buttonStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        buttonStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        buttonStackView.topAnchor.constraint(equalTo: dividerLineView.bottomAnchor, constant: 5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

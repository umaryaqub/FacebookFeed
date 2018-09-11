//
//  FeedController.swift
//  Facebook Feed
//
//  Created by Umar Yaqub on 05/09/2018.
//  Copyright © 2018 Umar Yaqub. All rights reserved.
//

import UIKit

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout, zoomImageDelegate {
    
    let blackBackgroundView = UIView()
    var postImageView: UIImageView?
    let navBarCoverView = UIView()
    let tabBarCoverView = UIView()
    let zoomIV = UIImageView()

    func didTapImage(imageView: UIImageView) {
        self.postImageView = imageView
        if let startingFrame = imageView.superview?.convert(imageView.frame, to: nil) {
            imageView.alpha = 0
            blackBackgroundView.frame = self.view.frame
            blackBackgroundView.backgroundColor = .black
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)
            
            navBarCoverView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 64)
            navBarCoverView.backgroundColor = .black
            navBarCoverView.alpha = 0
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.addSubview(navBarCoverView)
                tabBarCoverView.frame = CGRect(x: 0, y: keyWindow.frame.height - 49, width: view.frame.width, height: 49)
                tabBarCoverView.backgroundColor = .black
                tabBarCoverView.alpha = 0
                keyWindow.addSubview(tabBarCoverView)
            }
            
            zoomIV.frame = startingFrame
            zoomIV.isUserInteractionEnabled = true
            zoomIV.image = imageView.image
            zoomIV.contentMode = .scaleAspectFit
            zoomIV.clipsToBounds = true
            view.addSubview(zoomIV)
            
            zoomIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.blackBackgroundView.alpha = 1
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                let y = self.view.frame.height / 2 - height / 2
                self.zoomIV.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                self.navBarCoverView.alpha = 1
                self.tabBarCoverView.alpha = 1
            }, completion: nil)
        }
    }
    
    @objc private func handleZoomOut() {
        if let startingFrame = postImageView?.superview?.convert((postImageView?.frame)!, to: nil) {
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.zoomIV.frame = startingFrame
                self.blackBackgroundView.alpha = 0
                self.navBarCoverView.alpha = 0
                self.tabBarCoverView.alpha = 0
            }) { (success) in
                self.zoomIV.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.postImageView?.alpha = 1
                self.navBarCoverView.removeFromSuperview()
                self.tabBarCoverView.removeFromSuperview()
            }
        }
    }
    
    
    private let cellId = "cellId"
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = "Facebook Feed"
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
        
        var markPost = Post()
        markPost.name = "Mark Zuckerberg"
        markPost.caption = "This is the caption linked to the post below!"
        markPost.profileImageName = "MarkZuck"
        markPost.postImageUrl = "MarkPost"//"https://flic.kr/p/6vMNNU"
        markPost.likes = 500
        markPost.comments = 5.7
        
        var postSteve = Post()
        postSteve.name = "Steve Jobs"
        postSteve.caption = "This is the caption linked to the post below, \nThis is the caption linked to the post below, \nThis is the caption linked to the post below, \nThis is the caption linked to the post below!"
        postSteve.profileImageName = "SteveJobs"
        postSteve.postImageUrl = "StevePost"
        postSteve.likes = 300
        postSteve.comments = 6.7
        
        var postBill = Post()
        postBill.name = "Bill Gates"
        postBill.caption = "This is the caption linked to the post below, \nThis is the caption linked to the post below, \nThis is the caption linked to the post below, \nThis is the caption linked to the post below, \nThis is the caption linked to the post below, \nThis is the caption linked to the post below, \nThis is the caption linked to the post below, \nThis is the caption linked to the post below, \nThis is the caption linked to the post below!"
        postBill.profileImageName = "BillGates"
        postBill.postImageUrl = "BillPost"
        postBill.likes = 600
        postBill.comments = 10.7
        
        posts.append(markPost)
        posts.append(postSteve)
        posts.append(postBill)
        
        increaseNSURLCache()
    }
    
    private func increaseNSURLCache() {
        // increasing NSURL cache size
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let cacheUrl = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDiskPath")
        URLCache.shared = cacheUrl
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        cell.post = posts[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let postCaption = posts[indexPath.item].caption {
            let rect = NSString(string: postCaption).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
            let knownHeight = 50 + 20 + 30 + 40 + view.frame.width
            return CGSize(width: view.frame.width, height: rect.height + knownHeight)
        }
        return CGSize(width: view.frame.width, height: 515)
    }


}


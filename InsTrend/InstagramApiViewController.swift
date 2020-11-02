//
//  InstargramApiViewController.swift
//  InsTrend
//
//  Created by Admin on 20/08/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class InstagramApiViewController: UIViewController {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var instagramApi = InstagramApi.shared
    var testUserData = InstagramTestUser(access_token: "", user_id: 0)
    var instagramUser: InstagramUser?
    var signedIn = false
    var images = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if testUserData.user_id == 0 {
            performSegue(withIdentifier: "webViewSegue", sender: nil)
        } else {
            self.instagramApi.getInstagramUser(testUserData: self.testUserData) { [weak self] (user) in
                guard let self = self else { return }
                
                self.instagramUser = user
                self.signedIn = true
                
                DispatchQueue.main.async { [weak self] in
                    self?.usernameLabel.text = user.username
                }

                self.instagramApi.getMedia(testUserData: self.testUserData, instagramUser: user) { (media) in
                    for mediaElem in media {
                        if mediaElem.media_type != MediaType.VIDEO {
                            let media_url = mediaElem.media_url
                            
                            self.instagramApi.fetchImage(urlString: media_url, completion: { (fetchedImage) in
                                guard let imageData = fetchedImage else { return }
                                guard let image = UIImage(data: imageData) else { return }
                                        
                                self.images.append(image)
                                    
                                if self.images.count == self.instagramUser?.media_count {
                                    DispatchQueue.main.async { [weak self] in
                                        self?.photoCollectionView.reloadData()
                                    }
                                }
                            })
                            
                            print(media_url)
                        } else {
                            print("Fetched media is a video")
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width
    }
    
    @IBAction func photoLongPressed(_ sender: UILongPressGestureRecognizer) {
        guard let selectedIndexPath = photoCollectionView.indexPathForItem(at: sender.location(in: photoCollectionView)) else {
            return
        }
        
        switch(sender.state) {
        case .began:
            //Starts interactive movement
            photoCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            
            //Trying to animate
            UIView.animate(withDuration: 0.3, animations: {
                if let cell = self.photoCollectionView.cellForItem(at: selectedIndexPath) as? PhotoCollectionViewCell {
                    cell.photoImageView?.transform = (cell.contentView.transform.scaledBy(x: 0.9, y: 0.9))
                }
            })
        case .changed:
            //Updates the position of the cell based on the location of the longPressGesture
            if sender.location(in: sender.view!).x <= 10 {
                print(1)
            }
            
            photoCollectionView.updateInteractiveMovementTargetPosition(sender.location(in: sender.view!))
        case .ended:
            //Called wWhen the longPressGesture ends
            photoCollectionView.endInteractiveMovement()
        default:
            photoCollectionView.cancelInteractiveMovement()
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let controller = segue.destination as? WebViewController, segue.identifier == "webViewSegue" else { return }
//        
//        controller.instagramApi = instagramApi
//        controller.mainVC = self
//    }
    
    @IBAction func unwindToInstagramApiVC(segue: UIStoryboardSegue) {
        guard let controller = segue.source as? WebViewController, segue.identifier == "instagramApiSegue" else { return }
        guard let userData = controller.testUserData else { return }
        
        testUserData = userData
    }

}

extension InstagramApiViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        cell.photoImageView.image = images[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        UIView.animate(withDuration: 0.3, animations: {
            if let cell = self.photoCollectionView.cellForItem(at: destinationIndexPath) as? PhotoCollectionViewCell {
                cell.photoImageView?.transform = CGAffineTransform.identity
            }
        })
        
        //Replaces the photo in the images Array
        let photo = images.remove(at: sourceIndexPath.item)
        images.insert(photo, at: destinationIndexPath.item)
    }
}

extension InstagramApiViewController: UICollectionViewDelegateFlowLayout {
    //Set the inset value to section of collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    //Set the space between lines to section of collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    //Set the space between columns to section of collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    //Calculates the width and height of the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = 3 * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + 3 * CGFloat(3 - 1)
        let itemWidth = ((view.bounds.size.width - marginsAndInsets) / CGFloat(3).rounded(.down))
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

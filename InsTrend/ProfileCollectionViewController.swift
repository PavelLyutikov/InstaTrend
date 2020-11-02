//
//  ProfileCollectionViewController.swift
//  InsTrend
//
//  Created by Admin on 24/08/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ProfileCollectionViewController: UICollectionViewController {
    
    let instagramApi = InstagramApi.shared
    var testUserData = InstagramTestUser(access_token: "", user_id: 0)
    var instagramUser: InstagramUser?
    var images = [UIImage]()
    var profileImage: UIImage?
    let inset: CGFloat = 10
    let minimumLineSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    let cellsPerRow = 3

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
                
//                URLSession.shared.dataTask(with: URL(string: "https://graph.instagram.com/users/\(user.id)?access_token=\(self.testUserData.access_token)")!) { (data, response, error) in
//                    print(try? JSONSerialization.jsonObject(with: data!))
//                }.resume()

                self.instagramApi.getMedia(testUserData: self.testUserData, instagramUser: user) { (media) in
                    for mediaElem in media {
                        if mediaElem.media_type != MediaType.VIDEO {
                            let media_url = mediaElem.media_url
                            
                            self.instagramApi.fetchImage(urlString: media_url, completion: { (fetchedImage) in
                                guard let imageData = fetchedImage else { return }
                                guard let image = UIImage(data: imageData) else { return }
                                        
                                self.images.append(image)
                                    
                                if self.images.count == self.instagramUser?.media_count {
                                    self.profileImage = self.images[0]
                                    
                                    DispatchQueue.main.async { [weak self] in
                                        self?.collectionView.reloadData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? WebViewController, segue.identifier == "webViewSegue" else { return }
        
        controller.instagramApi = instagramApi
        controller.mainVC = self
    }
    
    @IBAction func unwindToProfileCVC(segue: UIStoryboardSegue) {
        guard let controller = segue.source as? WebViewController, segue.identifier == "profileSegue" else { return }
        guard let userData = controller.testUserData else { return }
        
        testUserData = userData
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionViewCell
            
            cell.profileImageView.image = profileImage
            cell.profileNameLabel.text = instagramUser?.username
            cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.width / 2
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        cell.photoImageView.image = images[indexPath.row - 1]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return indexPath.item != 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        if proposedIndexPath.row == 0 {
            return IndexPath(row: proposedIndexPath.row + 1 , section: proposedIndexPath.section)
        } else {
            return proposedIndexPath
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        images.insert(images.remove(at: sourceIndexPath.row - 1), at: destinationIndexPath.row - 1)
    }
}

extension ProfileCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.row == 0) {
            return CGSize(width: view.frame.size.width, height: view.frame.size.height / 3.5)
        }
        
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        
        return CGSize(width: itemWidth, height: itemWidth)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
        
        super.viewWillTransition(to: size, with: coordinator)
    }
}

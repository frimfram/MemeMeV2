//
//  MemeCollectionViewController.swift
//  MemeMeFinal
//
//  Created by Jean Ro on 8/21/17.
//  Copyright © 2017 Jean Ro. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SentMemesCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]!

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = applicationDelegate.memes
        
        sizeView(size: view.frame.size)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        collectionView?.reloadData()
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        sizeView(size: size)
    }
    
    func sizeView(size: CGSize) {
        guard (flowLayout != nil) else {
            return
        }

        let isLandscape: Bool = UIDevice.current.orientation.isLandscape
        
        let space: CGFloat = 5.0
        let dimension = isLandscape ? (size.width - (4 * space)) / 5.0 :
            (size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeGridCell", for: indexPath) as!MemesCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        //set the image and description
        cell.memeImageView.image = meme.memedImage
        
        return cell
    }
    
    // MARK: UICollectionView Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meme = memes[(indexPath as NSIndexPath).row]
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "MemeDetailsViewController") as? MemeDetailsViewController
        detailsVC?.image = meme.memedImage
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(detailsVC!, animated: true)
    }

}

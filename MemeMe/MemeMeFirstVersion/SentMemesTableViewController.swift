//
//  MemeTableViewController.swift
//  MemeMeFinal
//
//  Created by Jean Ro on 8/21/17.
//  Copyright © 2017 Jean Ro. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {

    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        tableView.separatorStyle = .none
    }
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        tableView.reloadData()
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(120)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell", for: indexPath)
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.imageView?.image = meme.memedImage
        
        //size the image view
        let imageSize: Int = 120
        let imageSizeCG = CGSize(width: imageSize, height: imageSize)
        UIGraphicsBeginImageContextWithOptions(imageSizeCG, false, UIScreen.main.scale)
        let imageRect = CGRect(x: 0, y: 0, width: imageSize, height: imageSize)
        cell.imageView?.image!.draw(in: imageRect)
        cell.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //set description
        cell.textLabel?.text = meme.topText + "..." + meme.bottomText
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meme = memes[(indexPath as NSIndexPath).row]
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "MemeDetailsViewController") as? MemeDetailsViewController
        detailsVC?.image = meme.memedImage
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(detailsVC!, animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}

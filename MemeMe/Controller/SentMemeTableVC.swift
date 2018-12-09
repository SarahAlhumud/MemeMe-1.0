//
//  SentMemeTableVC.swift
//  MemeMe
//
//  Created by SARA ALHUMUD on 4/2/1440 AH.
//  Copyright © 1440 SARA ALHUMUD. All rights reserved.
//

import UIKit

class SentMemeTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var memes: [Meme]! {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    @IBAction func addBtn(_ sender: Any) {
        let memeCreationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MemeCreationVC")
        
        present(memeCreationVC, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemeCell", for: indexPath) as! SentMemeTableViewCell
        
        cell.img.image = memes[indexPath.row].memedImage
        cell.label.text = memes[indexPath.row].topText + "..." + memes[indexPath.row].bottomText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let viewerVC = self.storyboard!.instantiateViewController(withIdentifier: "ViewerVC") as! MemeViewerVC
        viewerVC.meme = memes[(indexPath as NSIndexPath).row]
        
        navigationController!.pushViewController(viewerVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        tableView.reloadData()
        super.viewWillAppear(animated)
        print(memes)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    
    
}

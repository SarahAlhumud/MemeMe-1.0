//
//  MemeViewerVC.swift
//  MemeMe
//
//  Created by SARA ALHUMUD on 4/2/1440 AH.
//  Copyright © 1440 SARA ALHUMUD. All rights reserved.
//

import UIKit

class MemeViewerVC: UIViewController {

    @IBOutlet weak var memeImg: UIImageView!
        
    var meme: Meme!
    
    func updateUI() {
        //TODO : Design Custum Cell
        memeImg.image = meme.memedImage

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ThirdViewController.swift
//  apP
//
//  Created by Lluis Mather on 13/05/2017.
//  Copyright © 2017 Lluis Mather. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

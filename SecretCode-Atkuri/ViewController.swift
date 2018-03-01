//
//  ViewController.swift
//  SecretCode-Atkuri
//
//  Created by Atkuri,Ashok on 3/1/18.
//  Copyright © 2018 Atkuri,Ashok. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TVSymbols: UITableView!
    @IBOutlet weak var LBLStatus: UILabel!
    @IBOutlet weak var LBLGuess: UILabel!
    @IBOutlet weak var LBLPreviousGuess: UILabel!
    @IBOutlet weak var LBLHint: UILabel!
    @IBOutlet weak var BTNReset: UIButton!
    @IBOutlet weak var BTNHint: UIButton!
    @IBOutlet weak var BTNUndo: UIButton!   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  SecretCode-Atkuri
//
//  Created by Atkuri,Ashok on 3/1/18.
//  Copyright © 2018 Atkuri,Ashok. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var TVSymbols: UITableView!
    @IBOutlet weak var LBLStatus: UILabel!
    @IBOutlet weak var LBLGuess: UILabel!
    @IBOutlet weak var LBLPreviousGuess: UILabel!
    @IBOutlet weak var LBLHint: UILabel!
    @IBOutlet weak var BTNReset: UIButton!
    @IBOutlet weak var BTNHint: UIButton!
    @IBOutlet weak var BTNUndo: UIButton!   
    
    private var symbols:[String] = AppDelegate.codeWordInstance.getSymbols()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        TVSymbols.delegate = self // our tableView will use this class for both its delegate & data source
        TVSymbols.dataSource = self        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate.codeWordInstance.getSymbols().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Symbols")! // in lieu of UITableViewCell()
        cell.textLabel?.text = AppDelegate.codeWordInstance.getSymbols()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select..."
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        LBLHint.text = ""
        AppDelegate.codeWordInstance.addSymbolToGuess(guessSymbol: symbols[indexPath.row])
        LBLGuess.text = "Guess : \(AppDelegate.codeWordInstance.currentGuess())"
        LBLStatus.text = AppDelegate.codeWordInstance.getStatusMessage()        
        if AppDelegate.codeWordInstance.correctGuess() {
            LBLHint.isEnabled = false
            BTNUndo.isEnabled = false
            LBLHint.text = "You Won, Click reset to play again!!!!!."
        } else {
            BTNHint.isEnabled = true
            if AppDelegate.codeWordInstance.onSymbol == 0  {
                BTNUndo.isEnabled = false
                LBLPreviousGuess.text?.append("\nGuess \(AppDelegate.codeWordInstance.attempts-1): " + AppDelegate.codeWordInstance.currentGuess())
                AppDelegate.codeWordInstance.resetGuess()
            } else if AppDelegate.codeWordInstance.onSymbol == AppDelegate.codeWordInstance.count {
                BTNUndo.isEnabled = false
                BTNHint.isEnabled = false
            }else {
                BTNUndo.isEnabled = true
            }
        }
    }

    @IBAction func ResetOnClick(_ sender: Any) {
        AppDelegate.codeWordInstance.reset()
        LBLGuess.text = ""
        LBLStatus.text = ""
        LBLPreviousGuess.text = ""
        LBLHint.text = ""
        BTNUndo.isEnabled = false
    }
    
    @IBAction func HintOnclick(_ sender: Any) {
        LBLHint.text = AppDelegate.codeWordInstance.hint()
    }
    
    @IBAction func UndoOnclick(_ sender: Any) {
        AppDelegate.codeWordInstance.undoLastGuess()
        if AppDelegate.codeWordInstance.onSymbol == 0 {
            BTNUndo.isEnabled = false
        }
        LBLGuess.text = "Guess : " + AppDelegate.codeWordInstance.currentGuess()
        LBLStatus.text = AppDelegate.codeWordInstance.getStatusMessage()
    } 
}


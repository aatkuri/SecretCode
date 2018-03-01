//
//  CodeWord.swift
//  SecretCode-Atkuri
//
//  Created by Atkuri,Ashok on 3/1/18.
//  Copyright © 2018 Atkuri,Ashok. All rights reserved.
//

import Foundation


class CodeWord{
    // a. Symbols is an array of strings and will be the choices for the TableView
    private var _symbols:[String] = []
    // b. Count is the number of symbols in the code and guess.
    private var _count:Int
    // c. Code is an array of strings and is the secret code
    private var _code:[String] = []
    // d. Guess is an array of strings and holds the current guess.
    private var _guess:[String] = []
    // e. OnSymbol gives the index of the next place to add a symbol in the guess
    private var _OnSymbol:Int = 0
    //f. Attempts is the number of times that a guess has been made.
    private var _attempts:Int = 1
    // g. Status is the status message for the game.
    private var _status:String
    
    var count:Int { get{ return _count } }
    var code:[String] { get{ return _code } }
    var guess:[String] { get{ return _guess } }
    var onSymbol:Int { get{ return _OnSymbol } }
    var attempts:Int { get{ return _attempts } }
    
    private static var inst:CodeWord = CodeWord(4)
    
    /* h. It should have a single initializer that takes in the count for the size of  the code. It will initialize the array of symbols (There should be at least 4. It will create the secret code. Your project should work for a code length of 4 or larger. It will initialize the other attributes as needed. */
    private init(_ codeSize:Int){
        _count = codeSize
        _status = "Attempt \(_attempts): \(_guess.count) symbols guessed"
        setSymbols(uniCodeStartingChar: "A", noOfSymbols: 3, offSet: 1)
        _code = self.generateCodeWord()
    }
    
    /* i. It should have a method to add a symbol to the guess. Increase onSymbol by one. Set the status message to "Attempt X: X symbols guessed". If we filled the last position, reset onSymbol to zero. Count the number of correct positions. Set the status message to "Guess completed: x correct" */
    func addSymbolToGuess(guessSymbol:String){
        if _OnSymbol < _count-1 {
            _guess.append(guessSymbol)
            _OnSymbol += 1
            _status = "Attempt \(_attempts): \(_guess.count) symbols guessed"
        }else{
            if !isLastAttempt() {
                _guess.append(guessSymbol)
                _status = "Guess \(_attempts) completed: \(matchedSymbols()) correct"
                _OnSymbol = 0
                _attempts += 1
            }else{
                if _count-1 == _guess.count {
                    _guess.append(guessSymbol)
                }
                if correctGuess() {
                    _status = "Guess \(_attempts) completed: \(matchedSymbols()) correct"
                } else {
                    _status = "Unbroken Code – Press reset to start again."
                    
                }
            }
            setNumericStatusMsg()
        }
        print(_guess)
        print(_status)
    }
    
    //j. It should have a method that returns the number of places where the guess matches the code.
    func matchedSymbols() -> Int {
        var correct = 0;
        for i in 0 ..< _guess.count{
            if _guess[i] == _code[i] {
                correct += 1
            }
        }
        return correct
    }
    
    //k. It should have a method that returns a status message for the guess.
    func getStatusMessage() ->String {
        return _status
    }
    func increaseCodeSize(){
        _count += 1
    }
    private func setNumericStatusMsg(){
        if _symbols.count>0 && (Int)(UnicodeScalar(_symbols[0])!.value) >= 48
            && (Int)(UnicodeScalar(_symbols[_symbols.count-1])!.value) <= 57 {
            var sum = 0
            for i in 0 ..< _guess.count {
                let temp = Int(_guess[i])! - Int(_code[i])!
                if temp < 0 {
                    sum += temp * -1
                } else {
                    sum += temp
                }
            }
            _status += "\nSum of differences is \(sum)"
        }
    }
    
    //l. It should have a method that returns the current guess
    func currentGuess() -> String {
        var guess = ""
        for i in 0 ..< _guess.count {
            guess += "  " + _guess[i]
        }
        for _ in _guess.count ..< _count {
            guess += "  -"
        }
        print(guess)
        return guess.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    //m. It should have a method that returns true if the guess matches the code.
    func correctGuess() -> Bool {
        return matchedSymbols()==_count
    }
    
    //n. It should have a reset method that assigns different symbols to the code and sets the onLetter to zero.
    func reset(){
        _code = generateCodeWord()
        resetGuess()
        _OnSymbol = 0
        _attempts = 1
        _status = "Attempt \(_attempts): \(_guess.count) symbols guessed"
    }
    
    func resetGuess(){
        _guess = []
    }
    
    static func getInstance() -> CodeWord{
        return inst
    }
    
    func setSymbols(uniCodeStartingChar:String, noOfSymbols:Int, offSet:Int){
        let startIdx:Int = (Int)(UnicodeScalar(uniCodeStartingChar)!.value)
        _symbols = []
        for i in stride(from:startIdx, through:startIdx+(noOfSymbols*offSet), by :offSet) {
            _symbols.append("\(UnicodeScalar(i) ?? "A")")
        }
        reset()
    }
    
    func getSymbols() -> [String] {
        return _symbols
    }
    
    func isLastAttempt() -> Bool {
        return _attempts == 3
    }
    
    func undoLastGuess(){
        if _guess.count != 0 {
            _guess.removeLast()
            _OnSymbol -= 1
            _status = "Attempt \(_attempts): \(_guess.count) symbols guessed"
        }
    }
    
    func hint() -> String {
        for i in 0 ..< _symbols.count {
            if _symbols[i] == _code[_OnSymbol] {
                return "I am at position \(i+1) in symbol list."
            }
        }
        return "Sorry, I can't help you anymore."
    }
    
    private func generateCodeWord() -> [String] {
        var codeWord:[String] = []
        for _ in 0 ..< _count {
            let tem:Int = Int(arc4random_uniform(UInt32(_symbols.count)))
            codeWord.append(_symbols[tem])
        }
        print("Symbols are :",_symbols)
        print("Code is :",codeWord)
        return codeWord
    }
}

//
//  CodeWord.swift
//  SecretCode-Atkuri
//
//  Created by Atkuri,Ashok on 3/1/18.
//  Copyright © 2018 Atkuri,Ashok. All rights reserved.
//

import Foundation


class CodeWord{
    
    private var _symbols:[String] = []
    private var _count:Int
    private var _code:[String] = []
    private var _guess:[String] = []
    private var _OnSymbol:Int = 0
    private var _attempts:Int = 1
    private var _status:String
    
    var symbols:[String] {
        get { return _symbols }
        set { _symbols = newValue }
    }
    var count:Int { get{ return _count } }
    var code:[String] { get{ return _code } }
    var guess:[String] { get{ return _guess } }
    var onSymbol:Int { get{ return _OnSymbol } }
    var attempts:Int { get{ return _attempts } }
    
    private init(_ codeSize:Int){
        _count = codeSize
        _status = "Attempt \(_attempts): \(_guess.count) symbols guessed"
        _symbols = ["A","B","C","D"]
        _code = self.generateCodeWord()
    }
    
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
        }
    }
    
    func matchedSymbols() -> Int {
        var correct = 0;
        for i in 0 ..< _guess.count{
            if _guess[i] == _code[i] {
                correct += 1
            }
        }
        return correct
    }
    
    func getStatusMessage() ->String {
        return _status
    }
    
    func currentGuess() -> String {
        var guess = ""
        for i in 0 ..< _guess.count {
            guess += "  " + _guess[i]
        }
        for _ in _guess.count ..< _count {
            guess += "  -"
        }
        return guess.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func correctGuess() -> Bool {
        return matchedSymbols()==_count
    }
    
    func reset(){
        _code = generateCodeWord()
        _guess = []
        _OnSymbol = 0
        _attempts = 1
        _status = "Attempt \(_attempts): \(_guess.count) symbols guessed"
    }
    
    func resetGuess(){
        _guess = []
    }
    
    private static let codemodel:CodeWord = CodeWord(4)
    static func getInstance() -> CodeWord{
        return codemodel
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
            _attempts -= 1
            _status = "Attempt \(_attempts): \(_guess.count) symbols guessed"
        }
    }
    
    func hint() -> String {
        for i in 0 ..< _symbols.count {
            if _symbols[i] == _code[_OnSymbol] {
                return "I am at position \(i+1)."
            }
        }
        return "Sorry, I am out of hints."
    }
    
    private func generateCodeWord() -> [String] {
        var codeWord:[String] = []
        for _ in 0 ..< _count {
            let tem:Int = Int(arc4random_uniform(UInt32(_symbols.count)))
            codeWord.append(_symbols[tem])
        }
        return codeWord
    }
}

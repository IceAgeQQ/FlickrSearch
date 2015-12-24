//
//  OrderedDictionary.swift
//  FlickrSearch
//
//  Created by Chao Xu on 15/12/22.
//  Copyright © 2015年 Razeware. All rights reserved.
//

import Foundation

struct OrderedDictionary<KeyType: Hashable, ValueType> {
    typealias ArrayType = [KeyType]
    typealias DictionaryType = [KeyType: ValueType]
    
    var array = ArrayType()
    var dictionary = DictionaryType()
    var count: Int {
        return self.array.count
    }
    
    mutating func insert(value: ValueType, forKey key: KeyType, atIndex index: Int) -> ValueType? {
        var adjustedIndex = index
        let existingVale = self.dictionary[key]
        if existingVale != nil {
            let existingIndex = self.array.indexOf(key)!
            if existingIndex < index {
                adjustedIndex--
            }
            self.array.removeAtIndex(existingIndex)
        }
        self.array.insert(key, atIndex: adjustedIndex)
        self.dictionary[key] = value
        
        return existingVale
    }
    
    mutating func removeAtIndex(index: Int) -> (KeyType, ValueType) {
        precondition(index < self.array.count, "Index out-of-bounds")
        let key = self.array.removeAtIndex(index)
        let value = self.dictionary.removeValueForKey(key)!
        return (key, value)
    }
    
    subscript(key: KeyType) -> ValueType? {
        get {
            return self.dictionary[key]
        }
        set {
            if let index = self.array.indexOf(key){
                
            }else{
                self.array.append(key)
            }
            self.dictionary[key] = newValue
        }
    }
    
    subscript(index: Int) -> (KeyType, ValueType) {
        get {
            precondition(index < self.array.count, "Index out - of - bounds")
            
            let key = self.array[index]
            let value = self.dictionary[key]!
            return (key, value)
        }
        
    }
}





















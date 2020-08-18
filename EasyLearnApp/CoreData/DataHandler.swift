//
//  DataHandler.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 14.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import UIKit
import CoreData


///  Класс для обращения к CoreData
final class DataHandler : NSObject {
    
    private func saveContext() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let viewContext = appDelegate.persistentContainer.viewContext
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch let error as NSError {
                print("not Save==\(error),\(error.userInfo)")
            }
        }
    }
    
    /// Сохранение сета в CoreData
    /// - Parameters:
    ///   - name: название сета
    ///   - emoji: emoji для сета
    public func saveWordSet(name: String, emoji: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let viewContext = appDelegate.persistentContainer.viewContext
        let wordSet = WordSet(context: viewContext)
        wordSet.name = name
        wordSet.emoji = emoji
        wordSet.progress = 0.0
        wordSet.withWord = NSSet()
        print("WordSet with name \(String(describing: wordSet.name)) added")
        saveContext()
    }
    
    private func saveWord(word: String, translation: String) -> Word? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let viewContext = appDelegate.persistentContainer.viewContext
        let newWord = Word(context: viewContext)
        newWord.word = word
        newWord.translation = translation
        newWord.progress = 0.0
        newWord.wrongAnswer = 0
        newWord.rightAnswer = 0
        print("Word \(String(describing: newWord.word)) with translation \(String(describing: newWord.translation)) added")
        saveContext()
        return newWord
    }
    
    /// Добавление нового слова в сет
    /// - Parameters:
    ///   - name: имя сета
    ///   - word: слово, добавляемое в сет
    ///   - translation: перевод слова
    public func addWordtoSet(name: String, word: String, translation: String) {
        if let word = saveWord(word: word, translation: translation),
            let set = fetchWordSet(with: name) {
            if let setWithWord = set.withWord {
                set.withWord = NSSet(set: setWithWord.adding(word))
            } else {
                set.withWord = NSSet(object: word)
            }
            print("Word \(String(describing: word.word)) with translation \(String(describing: word.translation)) added to WordSet \(String(describing: set.name))")
            saveContext()
        }
    }
    
    /// Получение слов из определенного сета
    /// - Parameter setWithName: имя сета
    /// - Returns: Массив объектов типа WordModel, содержащий слово, перевод и текущий прогресс
    public func fetchWords(from setWithName: String) -> [WordModel]  {
        var wordArray: [WordModel] = []
        if let wordSet = fetchWordSet(with: setWithName) {
            if let setWithWords = wordSet.withWord {
                for (_,word) in setWithWords.allObjects.enumerated() {
                    if let word = word as? Word, let wordValue = word.word, let wordTranslation = word.translation {
                        wordArray.append(WordModel(word: wordValue, translation: wordTranslation, progress: word.progress, rightAnswer: Int(word.rightAnswer), wrongAnswer: Int(word.wrongAnswer)))
                    }
                }
            }
        }
        return wordArray
    }
    
    /// Получение сета
    /// - Parameter name: имя сета
    /// - Returns: сет типа WordSet?
    private func fetchWordSet(with name: String) -> WordSet? {
        guard  let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let viewContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WordSet")
        do {
            let wordSet = try viewContext.fetch(fetchRequest)
            for set in wordSet {
                if let set = set as? WordSet, set.name == name {
                    print("Fetch word set with name \(String(describing: set.name))")
                    return set
                }
            }
        } catch let error as NSError {
            print("not fetch==\(error),\(error.userInfo)")
        }
        return nil
    }
    
    
    /// Обновление прогресса для слова
    /// - Parameters:
    ///   - word: слово, для которого обновляется прогресс
    ///   - progressChange: значение типа Double, на которое изменяется прогресс
    public func updateWordProgress(word: String, progressChange: Double) {
        guard  let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let viewContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Word")
        do {
            let words = try viewContext.fetch(fetchRequest)
            for currentWord in words {
                if let currentWord = currentWord as? Word,
                    (currentWord.word?.trimmingCharacters(in: .whitespacesAndNewlines).capitalized == word.capitalized || currentWord.translation?.trimmingCharacters(in: .whitespacesAndNewlines).capitalized == word.capitalized)   {
                    if progressChange > 0 {
                        currentWord.rightAnswer += 1
                    } else if progressChange < 0 {
                        currentWord.wrongAnswer += 1
                    }
                    if (currentWord.progress + progressChange >= 0.0) && (currentWord.progress <= 1.0) {
                        currentWord.progress += progressChange
                    }
                }
            }
        } catch let error as NSError {
            print("not fetch==\(error),\(error.userInfo)")
        }
        saveContext()
    }
    
    private func setOverallSetProgress(setName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let viewContext = appDelegate.persistentContainer.viewContext
        let fetchRequestUser = NSFetchRequest<NSManagedObject>(entityName: "WordSet")
        do {
            let wordSets = try viewContext.fetch(fetchRequestUser)
            for wordSet in wordSets {
                if let wordSet = wordSet as? WordSet, wordSet.name == setName {
                    if let words = wordSet.withWord {
                        var sumProgress: Float = 0
                        for word in words {
                            if let word = word as? Word {
                                sumProgress += Float(word.progress)
                            }
                        }
                        wordSet.progress = Double(sumProgress / Float(words.count))
                    }
                }
            }
        } catch let error as NSError {
               print("not deleted==\(error),\(error.userInfo)")
        }
        saveContext()
    }
    
    
    /// Получение всех сохраненных сетов
    /// - Returns: массив объектов типа WordSet
    public func fetchAllWordSet() -> [WordSet]? {
        guard  let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let viewContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WordSet")
        do {
            let wordSet = try viewContext.fetch(fetchRequest)
            var resultSet: [WordSet]? = []
            for set in wordSet {
                if let set = set as? WordSet, let setName = set.name {
                    setOverallSetProgress(setName: setName)
                    resultSet?.append(set)
                }
            }
            return resultSet
        } catch let error as NSError {
            print("not fetch==\(error),\(error.userInfo)")
        }
        return nil
    }
    
    /// Удаление сета
    /// - Parameter name: имя удаляемого сета
    public func deleteWordSet(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let viewContext = appDelegate.persistentContainer.viewContext
        let fetchRequestUser = NSFetchRequest<NSManagedObject>(entityName: "WordSet")
        do {
            let wordSets = try viewContext.fetch(fetchRequestUser)
            for wordSet in wordSets {
                if let wordSet = wordSet as? WordSet, wordSet.name == name {
                    viewContext.delete(wordSet)
                    print("Deleted \(wordSet.value(forKey: "name") ?? "No Name Available")")
                }
            }
        } catch let error as NSError {
               print("not deleted==\(error),\(error.userInfo)")
        }
        saveContext()
    }
    
    
    /// Удаление слова из сета
    /// - Parameters:
    ///   - name: имя сета
    ///   - wordValue: удаляемое слово
    public func deleteWordfromSet(name: String, wordValue: String) {
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
               return
           }
           let viewContext = appDelegate.persistentContainer.viewContext
           let fetchRequestUser = NSFetchRequest<NSManagedObject>(entityName: "WordSet")
           do {
               let wordSets = try viewContext.fetch(fetchRequestUser)
               for wordSet in wordSets {
                   if let wordSet = wordSet as? WordSet, wordSet.name == name {
                    if let words = wordSet.withWord {
                        for word in words {
                            if let word = word as? Word, word.word == wordValue {
                                viewContext.delete(word)
                                print("Deleted \(String(describing: word.word))")
                            }
                        }
                    }
                   }
               }
           } catch let error as NSError {
                  print("not deleted==\(error),\(error.userInfo)")
           }
           saveContext()
       }
}

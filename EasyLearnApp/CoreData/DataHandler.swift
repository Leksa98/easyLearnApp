//
//  DataHandler.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 14.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import CoreData


///  Класс для обращения к CoreData
final class DataHandler : NSObject {
    
    // MARK: - Constants
    
    private enum Keys {
        static let word = "Word"
        static let wordSet = "WordSet"
    }
    
    // MARK: - Properties
    
    static let shared = DataHandler()
    
    lazy var group: DispatchGroup = {
        return DispatchGroup()
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EasyLearnApp")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading store failed \(error)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Init
    
    private override init() {}
    
    // MARK: - Private data handling functions
    
    private func saveWord(word: String, translation: String) -> Word? {
        if let newWord = NSEntityDescription.insertNewObject(forEntityName: Keys.word, into: context) as? Word {
            newWord.word = word
            newWord.translation = translation
            newWord.progress = 0.0
            newWord.wrongAnswer = 0
            newWord.rightAnswer = 0
            do {
                try context.save()
                print("Word \(String(describing: newWord.word)) with translation \(String(describing: newWord.translation)) added")
                return newWord
            } catch {
                print("Failed to save new word set: \(error)")
            }
        }
        return nil
    }
    
    private func setOverallSetProgress(setName: String) {
        let fetchRequest = NSFetchRequest<WordSet>(entityName: Keys.wordSet)
        fetchRequest.predicate = NSPredicate(format: "name == %@", setName)
        do {
            if let wordSet = try context.fetch(fetchRequest).first {
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
            do {
                try context.save()
            } catch let error as NSError {
                print("not Save==\(error),\(error.userInfo)")
            }
        } catch {
            print("Failed to set overall set progress: \(error)")
        }
    }
    
    // MARK: - Public data handling functions
    
    /// Сохранение сета в CoreData
    /// - Parameters:
    ///   - name: название сета
    ///   - emoji: emoji для сета
    public func saveWordSet(name: String, emoji: String) -> Bool {
        group.enter()
        
        let fetchRequest = NSFetchRequest<WordSet>(entityName: Keys.wordSet)
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            if (try context.fetch(fetchRequest).first) != nil {
                group.leave()
                return false
            }
        } catch {
            
        }
        if let newWordSet = NSEntityDescription.insertNewObject(forEntityName: Keys.wordSet, into: context) as? WordSet {
            newWordSet.name = name
            newWordSet.emoji = emoji
            newWordSet.progress = 0.0
            newWordSet.withWord = NSSet()
            let language = (UserDefaults.standard.object(forKey: "selectedLanguage") as? String) ?? "English"
            newWordSet.language = language
            do {
                try context.save()
                print("WordSet with name \(String(describing: newWordSet.name)) added")
                group.leave()
                return true
            } catch {
                print("Failed to save new word set: \(error)")
                group.leave()
            }
        }
        return false
    }
    
    /// Добавление нового слова в сет
    /// - Parameters:
    ///   - name: имя сета
    ///   - word: слово, добавляемое в сет
    ///   - translation: перевод слова
    public func addWordtoSet(name: String, word: String, translation: String) {
        group.enter()
        let fetchRequest = NSFetchRequest<WordSet>(entityName: Keys.wordSet)
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        let newWord = saveWord(word: word, translation: translation)
        do {
            if let wordSet = try context.fetch(fetchRequest).first {
                if let setWithWord = wordSet.withWord {
                    wordSet.withWord = NSSet(set: setWithWord.adding(newWord as Any))
                } else {
                    wordSet.withWord = NSSet(object: newWord as Any)
                }
                do {
                    try context.save()
                    print("Word \(String(describing: newWord?.word)) with translation \(String(describing: newWord?.translation)) added to WordSet \(String(describing: wordSet.name))")
                } catch let error as NSError {
                    print("not Save==\(error),\(error.userInfo)")
                }
            }
            group.leave()
        } catch {
            print("Failed to add word to set: \(error)")
            group.leave()
        }
    }
    
    /// Получение слов из определенного сета
    /// - Parameter setWithName: имя сета
    /// - Returns: Массив объектов типа WordModel, содержащий слово, перевод и текущий прогресс
    public func fetchWords(from setWithName: String) -> [WordModel]  {
        group.enter()
        var wordArray: [WordModel] = []
        let fetchRequest = NSFetchRequest<WordSet>(entityName: Keys.wordSet)
        fetchRequest.predicate = NSPredicate(format: "name == %@", setWithName)
        do {
            if let wordSet = try context.fetch(fetchRequest).first {
                if let setWithWords = wordSet.withWord {
                    for (_,word) in setWithWords.allObjects.enumerated() {
                        if let word = word as? Word, let wordValue = word.word, let wordTranslation = word.translation {
                            wordArray.append(WordModel(word: wordValue, translation: wordTranslation, progress: word.progress, rightAnswer: Int(word.rightAnswer), wrongAnswer: Int(word.wrongAnswer)))
                        }
                    }
                }
            }
            group.leave()
        } catch {
            print("Failed to fetch words from set: \(error)")
            group.leave()
        }
        return wordArray
    }
    
    /// Обновление прогресса для слова
    /// - Parameters:
    ///   - setName: имя сета
    ///   - word: слово, для которого обновляется прогресс
    ///   - progressChange: значение типа Double, на которое изменяется прогресс
    public func updateWordProgress(setName: String, wordUpdate: String, progressChange: Double) {
        group.enter()
        let fetchRequest = NSFetchRequest<WordSet>(entityName: Keys.wordSet)
        fetchRequest.predicate = NSPredicate(format: "name == %@", setName)
        do {
            if let wordSet = try context.fetch(fetchRequest).first {
                if let setWithWords = wordSet.withWord {
                    for (_,word) in setWithWords.allObjects.enumerated() {
                        if let word = word as? Word,
                            let wordValue = word.word,
                            let wordTranslation = word.translation,
                            wordValue.capitalized == wordUpdate.trimmingCharacters(in: .whitespacesAndNewlines).capitalized ||
                                wordTranslation.capitalized == wordUpdate.trimmingCharacters(in: .whitespacesAndNewlines).capitalized {
                            if progressChange > 0 {
                                word.rightAnswer += 1
                            } else if progressChange < 0 {
                                word.wrongAnswer += 1
                            }
                            if (word.progress + progressChange >= 0.0) && (word.progress <= 1.0) {
                                word.progress += progressChange
                            }
                            do {
                                try context.save()
                                print("progress updated")
                            } catch let error as NSError {
                                print("not Save==\(error),\(error.userInfo)")
                            }
                        }
                    }
                }
            }
            group.leave()
        } catch let error as NSError {
            print("not fetch==\(error),\(error.userInfo)")
            group.leave()
        }
    }
    
    /// Получение всех сохраненных сетов
    /// - Returns: массив объектов типа WordSet
    public func fetchAllWordSet() -> [WordSet]? {
        group.enter()
        let fetchRequest = NSFetchRequest<WordSet>(entityName: Keys.wordSet)
        let language = (UserDefaults.standard.object(forKey: "selectedLanguage") as? String) ?? "English"
        fetchRequest.predicate = NSPredicate(format: "language == %@", language)
        do {
            let sets = try context.fetch(fetchRequest)
            var result: [WordSet] = []
            for set in sets {
                guard let name = set.name else { return nil }
                setOverallSetProgress(setName: name)
                result.append(set)
            }
            group.leave()
            return result
        } catch {
            print("Failed to get word sets: \(error)")
            group.leave()
        }
        return nil
    }
    
    /// Удаление сета
    /// - Parameter name: имя удаляемого сета
    public func deleteWordSet(name: String) {
        group.enter()
        let fetchRequest = NSFetchRequest<WordSet>(entityName: Keys.wordSet)
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            if let wordSet = try context.fetch(fetchRequest).first {
                context.delete(wordSet)
                do {
                    try context.save()
                } catch let error as NSError {
                    print("not Save==\(error),\(error.userInfo)")
                }
            }
            group.leave()
        } catch {
            print("Failed to delete word set: \(error)")
            group.leave()
        }
    }
    
    /// Удаление слова из сета
    /// - Parameters:
    ///   - name: имя сета
    ///   - wordValue: удаляемое слово
    public func deleteWordfromSet(name: String, wordValue: String) {
        group.enter()
        let fetchRequest = NSFetchRequest<WordSet>(entityName: Keys.wordSet)
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            if let wordSet = try context.fetch(fetchRequest).first {
                if let words = wordSet.withWord {
                    for word in words {
                        if let word = word as? Word, word.word == wordValue {
                            context.delete(word)
                            print("Deleted \(String(describing: word.word))")
                        }
                    }
                }
            }
            do {
                try context.save()
            } catch let error as NSError {
                print("not Save==\(error),\(error.userInfo)")
            }
            group.leave()
        } catch let error as NSError {
            print("not deleted==\(error),\(error.userInfo)")
            group.leave()
        }
    }
}

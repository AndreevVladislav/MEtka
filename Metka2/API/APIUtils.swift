//
//  APIUtils.swift
//  Metka2
//
//  Created by Vladislav Andreev on 23.11.2024.
//

import Foundation
import Combine
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class ApiUtils: ObservableObject {
    
    //MARK: Функция регистрации пользователя
    func registerUser(email: String, password: String, userModel: UserModel, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))  // Возвращаем ошибку регистрации
                return
            }
            
            guard let userId = authResult?.user.uid else {
                completion(.failure(NSError(domain: "Auth", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve user ID"])))
                return
            }
            
            let db = Firestore.firestore()
            let userCollection = db.collection("users")
            
            var updatedUserModel = userModel
            updatedUserModel.id = userId  // Присваиваем Firestore ID
            
            do {
                let data = try Firestore.Encoder().encode(updatedUserModel)
                userCollection.document(userId).setData(data) { error in
                    if let error = error {
                        completion(.failure(error))  // Возвращаем ошибку сохранения в Firestore
                    } else {
                        completion(.success(()))  // Успешная регистрация и сохранение
                    }
                }
            } catch {
                completion(.failure(error))  // Ошибка при кодировании данных
            }
        }
    }
    
//    let userModel = UserModel(
//        clientID: 1234,
//        avatar: "https://example.com/avatar.png",
//        email: "test3@example.com",
//        position: "Дизигнер",
//        grade: "A",
//        cabinetID: 12,
//        fio: "Виктория Ящукова",
//        officeID: 34,
//        flag_isAdmin: 0
//    )
//
//    registerUser(email: userModel.email, password: "securePassword123", userModel: userModel) { result in
//        switch result {
//        case .success:
//            print("Пользователь успешно зарегистрирован и сохранен в Firestore")
//        case .failure(let error):
//            print("Ошибка при регистрации пользователя: \(error.localizedDescription)")
//        }
//    }
    
    //MARK: Функция авторизации пользователя и получение данных
    func loginUserAndFetchData(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))  // Возвращаем ошибку авторизации
                return
            }
            
            guard let userId = authResult?.user.uid else {
                completion(.failure(NSError(domain: "Auth", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve user ID"])))
                return
            }
            
            let db = Firestore.firestore()
            let userCollection = db.collection("users")
            
            userCollection.document(userId).getDocument { documentSnapshot, error in
                if let error = error {
                    completion(.failure(error))  // Возвращаем ошибку получения данных
                    return
                }
                
                guard let document = documentSnapshot, document.exists else {
                    completion(.failure(NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
                    return
                }
                
                do {
                    let user = try document.data(as: UserModel.self)
                    completion(.success(user))  // Возвращаем данные пользователя
                } catch {
                    completion(.failure(error))  // Ошибка при декодировании данных
                }
            }
        }
    }
    
//    loginUserAndFetchData(email: "test3@example.com", password: "securePassword123") { result in
//        switch result {
//        case .success(let userModel):
//            print("Пользователь успешно авторизован и данные получены:")
//            print("ID: \(userModel.clientID), ФИО: \(userModel.fio), Email: \(userModel.email)")
//        case .failure(let error):
//            print("Ошибка при авторизации или получении данных: \(error.localizedDescription)")
//        }
//    }
    
    // MARK: - Функция для сохранения guid пользователя в UserDefaults
    func saveUserIDToUserDefaults(UserInfo: UserInfo, key: String) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(UserInfo)
            UserDefaults.standard.set(data, forKey: key)
            print(UserInfo)
            print("UserInfo сохранен в UserDefaults")
        } catch {
            print("Ошибка при сохранении информации о пользователе в UserDefaults: \(error.localizedDescription)")
        }
    }
    
    
    //MARK: Функция сохранения единицы техники в fb
    func saveTechniqueToFirestore(technique: ModelTechnique, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        let collection = db.collection("techniques")
        
        // Поиск техники с данным `techID`
        collection.whereField("techID", isEqualTo: technique.techID).getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error)) // Ошибка при запросе
                return
            }
            
            // Если техника с таким `techID` найдена, обновляем её
            if let document = querySnapshot?.documents.first {
                do {
                    let data = try Firestore.Encoder().encode(technique)
                    collection.document(document.documentID).setData(data) { error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(()))
                        }
                    }
                } catch {
                    completion(.failure(error)) // Ошибка кодирования
                }
            } else {
                // Если техника не найдена, добавляем новую запись
                do {
                    let data = try Firestore.Encoder().encode(technique)
                    collection.addDocument(data: data) { error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(()))
                        }
                    }
                } catch {
                    completion(.failure(error)) // Ошибка кодирования
                }
            }
        }
    }

    
    //Функция получения всех предметов
    func fetchAllTechniques(completion: @escaping (Result<[ModelTechnique], Error>) -> Void) {
        let db = Firestore.firestore()
        let collection = db.collection("techniques")  // Название коллекции в Firestore
        
        collection.getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))  // Возвращаем ошибку, если не удаётся получить данные
                return
            }
            
            guard let querySnapshot = querySnapshot else {
                completion(.failure(NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "No data found"])))
                return
            }
            
            // Массив для хранения всех техник
            var techniques: [ModelTechnique] = []
            
            for document in querySnapshot.documents {
                do {
                    // Преобразуем данные в модель
                    let technique = try document.data(as: ModelTechnique.self)
                    techniques.append(technique)
                } catch {
                    completion(.failure(error))  // Ошибка при декодировании
                    return
                }
            }
            
            // Возвращаем успешный результат
            completion(.success(techniques))
        }
    }
    
    
    func fetchTechniqueByTechID(techID: Int, completion: @escaping (Result<ModelTechnique, Error>) -> Void) {
        let db = Firestore.firestore()
        let collection = db.collection("techniques")
        
        // Выполняем запрос с условием `techID == techID`
        collection.whereField("techID", isEqualTo: techID).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error)) // Возвращаем ошибку, если запрос не удался
                return
            }
            
            guard let documents = snapshot?.documents, let firstDoc = documents.first else {
                completion(.failure(NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Technique not found"])))
                return
            }
            
            do {
                let technique = try firstDoc.data(as: ModelTechnique.self) // Декодируем документ в модель `ModelTechnique`
                completion(.success(technique)) // Успешно возвращаем технику
            } catch {
                completion(.failure(error)) // Ошибка при декодировании
            }
        }
    }
    
   

    func saveOfficeMapToFirestore(map: OfficeMap, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        let mapCollection = db.collection("officeMaps")
        
        do {
            // Преобразуем карту в формат для Firestore
            let mapData = try Firestore.Encoder().encode(map)
            
            // Если id карты есть, обновляем документ, если нет - добавляем новый
            if let mapId = map.id {
                // Используем заданный id для сохранения карты
                mapCollection.document(mapId).setData(mapData) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            } else {
                // Если id нет, создаём новый документ с автоматически сгенерированным id
                let documentRef = mapCollection.document()
                var newMap = map
                newMap.id = documentRef.documentID  // Присваиваем уникальный id
                documentRef.setData(try! Firestore.Encoder().encode(newMap)) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        } catch {
            completion(.failure(error)) // Ошибка при кодировании данных
        }
    }
    
    func getOfficeMapFromFirestore(mapID: String, completion: @escaping (Result<OfficeMap, Error>) -> Void) {
        let db = Firestore.firestore()
        let mapCollection = db.collection("officeMaps")
        
        mapCollection.document(mapID).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                do {
                    // Декодируем данные из документа в объект OfficeMap
                    let map = try document.data(as: OfficeMap.self)
                    completion(.success(map))
                } catch {
                    completion(.failure(error)) // Ошибка при декодировании
                }
            } else {
                completion(.failure(NSError(domain: "Firestore", code: 404, userInfo: [NSLocalizedDescriptionKey: "Map not found"])))
            }
        }
    }
    
}

// Модель для карты
struct OfficeMap: Codable, Identifiable {
    @DocumentID var id: String?  // id карты, которое будет уникальным идентификатором
    var elements: [MapElement]  // Массив элементов карты
}

//
//  NFCReader.swift
//  Metka2
//
//  Created by Vladislav Andreev on 23.11.2024.
//

import CoreNFC
import SwiftUI

class NFCReader: NSObject, NFCNDEFReaderSessionDelegate, ObservableObject {
    @Published var message: String = ""

    private var session: NFCNDEFReaderSession?
    
    private let apiUtils = ApiUtils()

    func startScanning() {
        guard NFCNDEFReaderSession.readingAvailable else {
            print("NFC недоступен на этом устройстве")
            return
        }

        // Инициализация сессии
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.alertMessage = "Поднесите метку для считывания."
        session?.begin()
    }

    // MARK: - NFCNDEFReaderSessionDelegate

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Извлечение информации из NFC-метки
        for message in messages {
            for record in message.records {
                if let payload = String(data: record.payload, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.message = payload
                        print("Считано содержимое метки: \(payload)")
                        let modifID = self.removeFirstTwoCharacters(from: payload)
                        print("\(modifID) modifID")
                        self.apiUtils.fetchTechniqueByTechID(techID: Int(modifID) ?? 0) { result in
                            switch result {
                            case .success(let technique):
                                print("Техника найдена:")
                                print("ID: \(technique.id ?? "нет ID"), Name: \(technique.name), OS: \(technique.os), Status: \(technique.status)")
                            case .failure(let error):
                                print("Ошибка при получении техники: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
        }
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // Обработка ошибок
        if let error = error as? NFCReaderError {
            if error.code != .readerSessionInvalidationErrorFirstNDEFTagRead {
                print("Ошибка NFC: \(error.localizedDescription)")
            }
        }
    }
    
    func removeFirstTwoCharacters(from string: String) -> String {
        return String(string.dropFirst(3))
    }
}

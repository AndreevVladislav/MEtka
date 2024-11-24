//
//  NFCWriter.swift
//  Metka2
//
//  Created by Vladislav Andreev on 24.11.2024.
//

import Foundation
import CoreNFC
import SwiftUI

class NFCWriter: NSObject, NFCNDEFReaderSessionDelegate {
    private var nfcSession: NFCNDEFReaderSession?

    // Запуск сессии для записи текста
    func startSession(withText text: String) {
        guard NFCNDEFReaderSession.readingAvailable else {
            print("NFC не поддерживается на этом устройстве.")
            return
        }

        // Инициализация сессии
        nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.alertMessage = "Поднесите NFC-метку к устройству для записи."
        nfcSession?.begin()
        self.textToWrite = text
    }

    private var textToWrite: String?

    // MARK: - NFCNDEFReaderSessionDelegate

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Ничего не делаем при чтении, так как мы записываем.
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        if let nfcError = error as? NFCReaderError, nfcError.code != .readerSessionInvalidationErrorFirstNDEFTagRead {
            print("Сессия завершена с ошибкой: \(error.localizedDescription)")
        }
        self.nfcSession = nil
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        guard let tag = tags.first else {
            session.invalidate(errorMessage: "Не удалось обнаружить NFC-метку.")
            return
        }

        // Подключаемся к метке
        session.connect(to: tag) { [weak self] error in
            if let error = error {
                session.invalidate(errorMessage: "Ошибка подключения: \(error.localizedDescription)")
                return
            }

            self?.writeTextToTag(tag, session: session)
        }
    }

    private func writeTextToTag(_ tag: NFCNDEFTag, session: NFCNDEFReaderSession) {
        guard let text = textToWrite else {
            session.invalidate(errorMessage: "Текст для записи не указан.")
            return
        }

        // Создаем запись NDEF с текстом
        let ndefPayload = NFCNDEFPayload.wellKnownTypeTextPayload(string: text, locale: Locale(identifier: "en"))
        let ndefMessage = NFCNDEFMessage(records: [ndefPayload!])

        // Проверяем, поддерживает ли метка запись
        tag.queryNDEFStatus { status, capacity, error in
            if let error = error {
                session.invalidate(errorMessage: "Ошибка проверки NDEF-статуса: \(error.localizedDescription)")
                return
            }

            switch status {
            case .readWrite:
                // Записываем сообщение
                tag.writeNDEF(ndefMessage) { error in
                    if let error = error {
                        session.invalidate(errorMessage: "Ошибка записи: \(error.localizedDescription)")
                    } else {
                        session.alertMessage = "Текст успешно записан на метку."
                        session.invalidate()
                    }
                }

            case .readOnly:
                session.invalidate(errorMessage: "Метка только для чтения.")
            case .notSupported:
                session.invalidate(errorMessage: "Метка не поддерживает формат NDEF.")
            @unknown default:
                session.invalidate(errorMessage: "Неизвестный статус метки.")
            }
        }
    }
}

//
//  MapsRedView.swift
//  Metka2
//
//  Created by Vladislav Andreev on 22.11.2024.
//

import Foundation
import SwiftUI

struct OfficeMapView: View {
    @State private var elements: [MapElement] = []
    @State private var isAddingElement = false

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            // Отображение всех добавленных элементов
            ForEach(elements) { element in
                ZStack {
                    // Фигура элемента (аудитория или стол)
                    Rectangle()
                        .fill(element.type == .auditorium ? Color.gray.opacity(0.7) : Color.black.opacity(0.7))
                        .frame(width: element.size.width, height: element.size.height)
                    
                    // Название элемента
                    Text(element.name)
                        .foregroundColor(.white)
                        .font(.caption)
                        .padding(4)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(4)
                }
                .position(element.position)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if let index = elements.firstIndex(where: { $0.id == element.id }) {
                                elements[index].position = gesture.location
                            }
                        }
                )
            }

            // Кнопка для добавления нового элемента
            VStack {
                Spacer()
                Button(action: {
                    isAddingElement.toggle()
                }) {
                    Text("Добавить элемент")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
            }
            
        }
        .sheet(isPresented: $isAddingElement) {
            AddElementView { newElement in
                elements.append(newElement)
            }
        }
    }
}

struct AddElementView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedType: ElementType = .auditorium
    @State private var width: CGFloat = 100
    @State private var height: CGFloat = 100
    @State private var name: String = ""
    @State private var previewPosition: CGPoint = CGPoint(x: 150, y: 150)

    var onAdd: (MapElement) -> Void

    var body: some View {
        NavigationView {
            VStack {
                // Выбор типа элемента
                Picker("Тип элемента", selection: $selectedType) {
                    Text("Аудитория").tag(ElementType.auditorium)
                    Text("Стол").tag(ElementType.table)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Превью элемента с динамическими размерами
                ZStack {
                    Color.gray.opacity(0.2)
                        .frame(height: 200)
                        .cornerRadius(8)

                    Rectangle()
                        .fill(selectedType == .auditorium ? Color.gray.opacity(0.7) : Color.black.opacity(0.7))
                        .frame(width: width, height: height)
                        .overlay(
                            Text(name.isEmpty ? "Название" : name)
                                .foregroundColor(.white)
                                .font(.caption)
                                .padding(4)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(4),
                            alignment: .center
                        )
                    
                    
                }
                .padding()

                // Настройка размеров
                Form {
                    Section(header: Text("Размеры элемента")) {
                        HStack {
                            Text("Ширина:")
                            Slider(value: $width, in: 50...300, step: 10)
                            Text("\(Int(width))")
                        }
                        HStack {
                            Text("Высота:")
                            Slider(value: $height, in: 50...300, step: 10)
                            Text("\(Int(height))")
                        }
                    }

                    // Ввод названия элемента
                    Section(header: Text("Название элемента")) {
                        TextField("Введите название", text: $name)
                    }
                }
            }
            .navigationTitle("Добавить элемент")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Добавить") {
                        let newElement = MapElement(
                            type: selectedType,
                            name: name.isEmpty ? "Без названия" : name,
                            size: CGSize(width: width, height: height),
                            position: CGPoint(x: 200, y: 200) // Начальная позиция
                        )
                        onAdd(newElement)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// Модель данных для элемента карты
struct MapElement: Identifiable {
    let id = UUID()
    let type: ElementType
    var name: String
    var size: CGSize
    var position: CGPoint
}

// Типы элементов карты
enum ElementType {
    case auditorium, table
}



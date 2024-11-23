//
//  MapsRedView.swift
//  Metka2
//
//  Created by Vladislav Andreev on 22.11.2024.
//

import Foundation
import SwiftUI

import Foundation
import SwiftUI

// Главное представление карты офиса
struct OfficeMapView: View {
    @State private var elements: [MapElement] = [] // Список элементов
    @State private var isAddingElement = false     // Флаг для добавления элемента
    @State private var selectedElement: MapElement? = nil // Элемент для редактирования
    @State private var scale: CGFloat = 1.0        // Текущий масштаб карты
    private let apiUtils = ApiUtils()

    var body: some View {
        ZStack {
            // Фон карты
            Consts.Colors.Gray_C9
                .ignoresSafeArea()

            // Элементы на карте с учетом масштаба
            ForEach(elements) { element in
                ZStack {
                    Rectangle()
                        .fill(getColor(for: element.type))
                        .frame(width: element.size.width, height: element.size.height)
                        .overlay(
                            Rectangle()
                                .stroke(Color.gray, lineWidth: 2) // Обводка
                        )

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
                .onTapGesture {
                    selectedElement = element
                }
            }
            .scaleEffect(scale) // Применение масштаба

            // Кнопки управления масштабом
            VStack {
                
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            scale += 0.1 // Увеличить масштаб
                        }) {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Consts.Colors.Green_51)
                        }
                        .padding(.bottom, 10)

                        Button(action: {
                            scale = max(0.5, scale - 0.1) // Уменьшить масштаб (минимум 0.5)
                        }) {
                            Image(systemName: "minus.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Consts.Colors.Green_51)
                        }
                    }
                    .padding()
                }
                Spacer()

            }

            // Кнопка добавления элемента
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
                Button(action: {
                    let officeMap = OfficeMap(id: "customMapID123", elements: elements)
                    self.apiUtils.saveOfficeMapToFirestore(map: officeMap) { result in
                        switch result {
                        case .success:
                            print("Карта успешно сохранена")
                        case .failure(let error):
                            print("Ошибка при сохранении карты: \(error.localizedDescription)")
                        }
                    }
                }) {
                    Text("Сохранить карту")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
            }
            .padding(.bottom, 20)
        }
        .onAppear {
            self.apiUtils.getOfficeMapFromFirestore(mapID: "customMapID123") { result in
                switch result {
                case .success(let map):
                    print("Карта получена: \(map)")
                    elements = map.elements
                case .failure(let error):
                    print("Ошибка при получении карты: \(error.localizedDescription)")
                }
            }
        }

        // Меню добавления элемента
        .sheet(isPresented: $isAddingElement) {
            AddElementView { newElement in
                elements.append(newElement)
            }
        }

        // Меню редактирования элемента
        .sheet(item: $selectedElement) { element in
            EditElementView(element: element) { updatedElement in
                if let index = elements.firstIndex(where: { $0.id == updatedElement.id }) {
                    elements[index] = updatedElement
                }
            }
        }
    }

    // Цвета для элементов
    func getColor(for type: ElementType) -> Color {
        switch type {
        case .auditorium:
            return Color.clear
        case .table:
            return Color.blue.opacity(0.7)
        case .chair:
            return Color.green.opacity(0.7)
        case .partition:
            return Color.gray.opacity(0.7)
        case .computer:
            return Color.purple.opacity(0.7)
        }
    }
}

// Окно добавления нового элемента
struct AddElementView: View {
    // Контекст для закрытия окна
    @Environment(\.dismiss) var dismiss
    // Параметры размера нового элемента
    @State private var width: CGFloat = 100
    @State private var height: CGFloat = 100
    // Название нового элемента
    @State private var name: String = ""
    // Позиция элемента в предварительном просмотре
    @State private var previewPosition: CGPoint = CGPoint(x: 150, y: 150)

    // Замыкание, вызываемое при добавлении нового элемента
    var onAdd: (MapElement) -> Void

    @State private var selectedType: ElementType = .auditorium // Выбранный тип элемента

    var body: some View {
        NavigationView {
            VStack {
                // Выпадающий список для выбора типа элемента
                Menu {
                    ForEach(ElementType.allCases, id: \.self) { type in
                        Button(action: {
                            selectedType = type
                        }) {
                            Text(type.rawValue)
                        }
                    }
                } label: {
                    HStack {
                        Text("Тип элемента: \(selectedType.rawValue)")
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                }
                .padding()

                // Превью элемента
                ZStack {
                    Color.gray.opacity(0.2)
                        .frame(height: 200)
                        .cornerRadius(8)

                    Rectangle()
                        .fill(selectedType == .partition ? Color.clear : Color.clear)
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
struct MapElement: Codable, Identifiable {
    let id = UUID() // Уникальный идентификатор
    var type: ElementType // Тип элемента (аудитория или стол)
    var name: String // Название элемента
    var size: CGSize // Размеры элемента
    var position: CGPoint // Позиция элемента на карте
}

// Типы элементов карты
enum ElementType: String, Codable, CaseIterable {
    case auditorium = "Кабинет"
    case table = "Стол"
    case chair = "Стул"
    case partition = "Перегородка"
    case computer = "Компьютер"
}

struct EditElementView: View {
    @Environment(\.dismiss) var dismiss
    @State var element: MapElement // Текущий элемент
    var onSave: (MapElement) -> Void

    var body: some View {
        NavigationView {
            VStack {
                Picker("Тип элемента", selection: $element.type) {
                    Text("Кабинет").tag(ElementType.auditorium)
                    Text("Стол").tag(ElementType.table)
                    Text("Стул").tag(ElementType.chair)
                    Text("Перегородка").tag(ElementType.partition)
                    Text("Компьютер").tag(ElementType.computer)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Превью с текущими размерами
                ZStack {
                    Color.gray.opacity(0.2)
                        .frame(height: 200)
                        .cornerRadius(8)

                    Rectangle()
                        .fill(getColor(for: element.type))
                        .frame(width: element.size.width, height: element.size.height)
                        .overlay(
                            Text(element.name.isEmpty ? "Название" : element.name)
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
                            Slider(value: $element.size.width, in: 50...300, step: 10)
                            Text("\(Int(element.size.width))")
                        }
                        HStack {
                            Text("Высота:")
                            Slider(value: $element.size.height, in: 50...300, step: 10)
                            Text("\(Int(element.size.height))")
                        }
                    }

                    // Ввод названия элемента
                    Section(header: Text("Название элемента")) {
                        TextField("Введите название", text: $element.name)
                    }
                }
            }
            .navigationTitle("Редактировать элемент")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        onSave(element)
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

    // Функция получения цвета
    func getColor(for type: ElementType) -> Color {
        switch type {
        case .auditorium:
            return Color.clear
        case .table:
            return Color.blue.opacity(0.7)
        case .chair:
            return Color.green.opacity(0.7)
        case .partition:
            return Color.gray.opacity(0.7)
        case .computer:
            return Color.purple.opacity(0.7)
        }
    }
}




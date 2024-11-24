//
//  MapsRedView.swift
//  Metka2
//
//  Created by Vladislav Andreev on 22.11.2024.
//

import Foundation
import SwiftUI


// Главное представление карты офиса
struct OfficeMapView: View {
    @State private var elements: [MapElement] = [] // Список элементов
    @State private var elementsSave: [MapElement] = [] // Список элементов
    @State private var isAddingElement = false     // Флаг для добавления элемента
    @State private var selectedElement: MapElement? = nil // Элемент для редактирования
    @State private var scale: CGFloat = 1.0        // Текущий масштаб карты
    private let apiUtils = ApiUtils()
    
    @State private var flag_redMap = false
    
    @State private var showAlert = false
    
    @ObservedObject var tecniqueManager = TecniqueManager.shared
    
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
                                .stroke(Color.black, lineWidth: 2) // Обводка
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
                            if UserInfoManager.shared.flag_isAdmin == 1 && flag_redMap {
                                if let index = elements.firstIndex(where: { $0.id == element.id }) {
                                    elements[index].position = gesture.location
                                }
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
                        .padding(.bottom, 10)
                        
                        if !flag_redMap && UserInfoManager.shared.flag_isAdmin == 1 {
                            Button(action: {
                                flag_redMap = true
                                elementsSave = elements
                            }) {
                                Image(systemName: "square.and.pencil.circle")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Consts.Colors.Green_51)
                            }
                        }
                    }
                    .padding()
                }
                Spacer()
                
            }
            
            // Кнопка добавления элемента
            
            VStack {
                Spacer()
                HStack {
                    if UserInfoManager.shared.flag_isAdmin == 1 && flag_redMap {
                        Button(action: {
                            isAddingElement.toggle()
                        }) {
                            Text("Добавить")
                                .font(.headline)
                                .foregroundColor(Consts.Colors.black)
                                .padding()
                                .background(Consts.Colors.Green_51)
                                .cornerRadius(8)
                        }
                    }
                    
                    Button(action: {
                        self.apiUtils.getOfficeMapFromFirestore(mapID: "customMapID123") { result in
                            switch result {
                            case .success(let map):
                                print("Карта получена: \(map)")
                                elements = map.elements
                            case .failure(let error):
                                print("Ошибка при получении карты: \(error.localizedDescription)")
                            }
                        }
                        
                    }) {
                        Image(systemName: "arrow.clockwise.square.fill")
                            .foregroundStyle(Consts.Colors.Green_51)
                            .font(Font.system(size: 48))
                    }
                    if UserInfoManager.shared.flag_isAdmin == 1 && flag_redMap {
                        Button(action: {
                            self.showAlert = true
                        }) {
                            Text("Сохранить")
                                .font(.headline)
                                .foregroundColor(Consts.Colors.black)
                                .padding()
                                .background(Consts.Colors.Green_51)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.bottom, 50)
            }
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
        .sheet(item: $selectedElement) { selectedElement in
            if UserInfoManager.shared.flag_isAdmin == 1 && flag_redMap {
                if let index = elements.firstIndex(where: { $0.id == selectedElement.id }) {
                    EditElementView(element: $elements[index], onDelete: {
                        elements.remove(at: index) // Удаляем элемент из списка
                        self.selectedElement = nil // Закрываем редактор
                    })
                }
            } else {
                
                Text("name \(selectedElement.name)")
                Text("cabinetID \(selectedElement.cabinetID)")
            }
        }
        .alert("Сохранить изменения?", isPresented: $showAlert) {
                   Button("да") {
                       let officeMap = OfficeMap(id: "customMapID123", elements: elements)
                       self.apiUtils.saveOfficeMapToFirestore(map: officeMap) { result in
                           switch result {
                           case .success:
                               print("Карта успешно сохранена")
                           case .failure(let error):
                               print("Ошибка при сохранении карты: \(error.localizedDescription)")
                           }
                       }
                       self.showAlert = false
                       self.flag_redMap = false
                   }
                   Button("нет", role: .cancel) { // Кнопка с ролью "отмена"
                       self.elements = self.elementsSave
                       self.showAlert = false
                       self.flag_redMap = false
                   }
        } message: {
            Text("")
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
    // Позиция элемента в предварительном просмотре
    @State private var previewPosition: CGPoint = CGPoint(x: 150, y: 150)
    @State private var name: String = ""
    @State private var cabinetID: String = ""
    @State private var type: String = ""

    // Замыкание, вызываемое при добавлении нового элемента
    var onAdd: (MapElement) -> Void

    @State private var selectedType: ElementType = .auditorium // Выбранный тип элемента
    private let apiUtils = ApiUtils()


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
                Form {
                // Превью элемента
                ZStack {
                    Color.gray.opacity(0.2)
                        .frame(height: 200)
                        .cornerRadius(8)

                    Rectangle()
                        .fill(getColor(for: selectedType))
                        .frame(width: width, height: height)
                        .overlay(
                            // Добавление чёрной обводки
                            Rectangle()
                                .stroke(Color.black, lineWidth: 2)
                        )
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
                    
                    Section(header: Text("Информация")) {
                        TextField("ID (число)", text: $cabinetID)
                            .keyboardType(.numberPad)
                        TextField("Название элемента", text: $name)
                        TextField("Тип", text: $type)
                    }
                    
                    Section(header: Text("")) {
                        VStack {
                            Spacer()
                        }
                        .frame(height: 300)
                    }
                    
                   
                }
                
            }
            .navigationTitle("Добавить элемент")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Добавить") {
                        let newElement = MapElement(
                            type: selectedType,
                            name: name.isEmpty ? "" : name,
                            size: CGSize(width: width, height: height),
                            position: CGPoint(x: 200, y: 200),
                            cabinetID: Int(cabinetID) ?? 0// Начальная позиция
                        )
                        onAdd(newElement)
                        addToFirestore()
                        
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
            }
            .ignoresSafeArea()
            Spacer()
        }
        .ignoresSafeArea()
    }
    
    // Функция для определения цвета элемента
    func getColor(for type: ElementType) -> Color {
        switch type {
        case .auditorium:
            return Color.clear // Прозрачный фон
        case .table:
            return Color.blue.opacity(0.7) // Цвет для столов
        case .chair:
            return Color.green.opacity(0.7) // Цвет для стульев
        case .partition:
            return Color.gray.opacity(0.7) // Цвет для перегородок
        case .computer:
            return Color.purple.opacity(0.7) // Цвет для компьютеров
        }
    }
    
    private func addToFirestore() {
        guard let elementID = Int(cabinetID), !name.isEmpty, !type.isEmpty else { return }
        
        let newCabinet = ModelCabinet(
            cabinetID: elementID,
            name: name,
            type: type,
            peoples: [], // Пустой массив пользователей
            techniques: [] // Пустой массив техники
        )
        
        self.apiUtils.saveCabinetToFirestore(cabinet: newCabinet) { result in
            switch result {
            case .success:
                print("Кабинет успешно сохранён!")
                dismiss()
            case .failure(let error):
                print("Ошибка сохранения: \(error.localizedDescription)")
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
    var cabinetID: Int
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
    @State private var selectedType: ElementType
    @State private var width: CGFloat
    @State private var height: CGFloat
    @State private var name: String
    @Binding var element: MapElement
    var onDelete: () -> Void

    init(element: Binding<MapElement>, onDelete: @escaping () -> Void) {
        self._element = element
        self._selectedType = State(initialValue: element.wrappedValue.type)
        self._width = State(initialValue: element.wrappedValue.size.width)
        self._height = State(initialValue: element.wrappedValue.size.height)
        self._name = State(initialValue: element.wrappedValue.name)
        self.onDelete = onDelete
    }

    var body: some View {
        NavigationView {
            VStack {
                // Превью элемента
                ZStack {
                    Color.gray.opacity(0.2)
                        .frame(height: 200)
                        .cornerRadius(8)

                    Rectangle()
                        .fill(getColor(for: selectedType))
                        .frame(width: width, height: height)
                        .overlay(
                            Rectangle()
                                .stroke(Color.black, lineWidth: 2)
                        )
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
                    Section(header: Text("Тип элемента")) {
                        Picker("Тип элемента", selection: $selectedType) {
                            Text("Аудитория").tag(ElementType.auditorium)
                            Text("Стол").tag(ElementType.table)
                            Text("Стул").tag(ElementType.chair)
                            Text("Перегородка").tag(ElementType.partition)
                            Text("Компьютер").tag(ElementType.computer)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }

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

                    Section(header: Text("Название элемента")) {
                        TextField("Введите название", text: $name)
                    }
                }

                Spacer()

                // Кнопка удаления
                Button(action: {
                    onDelete()
                    dismiss()
                }) {
                    Text("Удалить элемент")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("Редактировать элемент")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        element.type = selectedType
                        element.size = CGSize(width: width, height: height)
                        element.name = name
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

    private func getColor(for type: ElementType) -> Color {
        switch type {
        case .auditorium: return Color.clear
        case .table: return Color.blue.opacity(0.7)
        case .chair: return Color.green.opacity(0.7)
        case .partition: return Color.gray.opacity(0.7)
        case .computer: return Color.purple.opacity(0.7)
        }
    }
}




import Foundation

struct TaskItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var flowerName: String
    var isCompleted: Bool
    var dueDate: Date
    var lastWateringDate: Date
    var nextWateringDate: Date
}

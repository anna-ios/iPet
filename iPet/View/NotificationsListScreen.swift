//
//  NotificationsListScreen.swift
//  iPet
//
//  Created by Zelinskaya Anna on 15.05.2021.
//

import SwiftUI

struct NotificationsListScreen: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \NotificationItem.timestamp, ascending: true)],
        animation: .default)
    private var notifications: FetchedResults<NotificationItem>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject private var notificationsViewModel: NotificationsViewModel
    @EnvironmentObject private var petViewModel: PetViewModel
    
    @State private var showModal: Bool = false
    @State private var listSelection: Int?
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(Array(notifications.enumerated()), id: \.offset) { index, notification in
                        NavigationLink(destination: EditNotificationView(notification: notification),
                                       tag:index,
                                       selection:$listSelection) {
                            NotificationCell(title: notification.title,
                                             pet: notification.pet.name,
                                             date: notification.date,
                                             text: notification.text,
                                             repeatType: notification.repeatType)
                                .listRowBackground(Color(.systemGray6))
                        }
                    }
                    .onDelete(perform: removeRows(at:))
                }
                .listStyle(InsetGroupedListStyle())
                .sheet(isPresented: $showModal) {
                    NavigationView {
                        EditNotificationView(notification: NotificationItem())
                            .environmentObject(self.notificationsViewModel)
                            .environmentObject(self.petViewModel)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showModal = true
                    }
                    label: {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .padding()
                    }
                }
            }
            .navigationTitle("Notifications")
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        let notification = notifications[index]
        removeNotificationRequest(id: notification.id)
        notificationsViewModel.removeNotification(notification: notification, viewContext: viewContext)
    }
}


struct NotificationCell: View {
    private(set) var title: String?
    private(set) var pet: String?
    private(set) var date: Date
    private(set) var text: String?
    private(set) var repeatType: String
    
    var body: some View {
        VStack(alignment: .leading) {
            if let title = title, !title.isEmpty {
                Text("\(title)")
                    .font(.title2)
            }
            if let pet = pet, !pet.isEmpty {
                Text("\(pet)")
                    .font(.body)
            }
            if let stringDate = getDateString(date: date),
               let stringRepeat = repeatType == getRepeatString(.never) ? "" : ", \(repeatType)" {
                Text("\(stringDate)\(stringRepeat)")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
            if let text = text, !text.isEmpty {
                Text("\(text)")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
        }
    }
    
    private func getDateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter.string(from: date)
    }
}

struct NotificationsListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsListScreen()
    }
}

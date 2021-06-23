//
//  EditNotificationView.swift
//  iPet
//
//  Created by Zelinskaya Anna on 15.05.2021.
//

import SwiftUI

struct EditNotificationView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pet.timestamp, ascending: true)],
        animation: .default)
    private var pets: FetchedResults<Pet>
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject private var petViewModel: PetViewModel
    @EnvironmentObject private var notificationsViewModel: NotificationsViewModel
    
    private var notification: NotificationItem = NotificationItem()
    
    @State private var date: Date = Date()
    @State private var activity: ActivityType = .walk
    @State private var title: String = ""
    @State private var pet: Pet = Pet()
    @State private var text: String = ""
    @State private var repeatPeriod: String = getRepeatString(.never)
    
    @State private var selectedPets = Set<String>()
    @State private var selectedActivities = Set<String>()
    
    private var checked: Bool {
        selectedActivities.contains(getActivityTypeString(.other))
    }
    
    @State private var CheckMarks = [
        CheckMark(activity: .walk),
        CheckMark(activity: .feed),
        CheckMark(activity: .groom),
        CheckMark(activity: .trim),
        CheckMark(activity: .vaccinate),
        CheckMark(activity: .other)
    ]
    
    @State private var repeatPeriods = [
        getRepeatString(.never),
        getRepeatString(.daily),
        getRepeatString(.weekly),
        getRepeatString(.monthly),
        getRepeatString(.yearly)
    ]
    
    init(notification: NotificationItem) {
        if notification.managedObjectContext != nil {
            self.notification = notification
            _date = State(initialValue:notification.date)
            _activity = State(initialValue:notification.activity)
            _title = State(initialValue:notification.title)
            _selectedActivities = State(initialValue:Set([getActivityTypeString(notification.activity)]))
            _pet = State(initialValue:notification.pet)
            _selectedPets = State(initialValue:Set([notification.pet.name]))
            _text = State(initialValue: notification.text ?? "")
            _repeatPeriod = State(initialValue:notification.repeatType)
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("pets")) {
                List(pets, selection: $selectedPets) { item in
                    CheckBoxRow(selectedItems: $selectedPets, name: item.name)
                        .onTapGesture {
                            pet = item
                            selectedPets = Set([item.name])
                        }
                }
            }
            .listRowBackground(Color(.systemGray6))
            Section(header: Text("title")) {
                List(CheckMarks, selection: $selectedActivities) { item in
                    CheckBoxRow(selectedItems: $selectedActivities, name: item.name)
                        .onTapGesture {
                            activity = item.activity
                            title = item.activity != .other ? item.name : ""
                            selectedActivities = Set([getActivityTypeString(item.activity)])
                        }
                }
            }
            .listRowBackground(Color(.systemGray6))
            if checked {
                Section(header: Text("user title")) {
                    TextField("", text: $title)
                }
                .listRowBackground(Color(.systemGray6))
            }
            Section(header: Text("description")) {
                TextField("", text: $text)
                    .lineLimit(2)
            }
            .listRowBackground(Color(.systemGray6))
            Section {
                Picker("Repeat", selection: $repeatPeriod) {
                    ForEach(repeatPeriods, id: \.self) {
                        Text($0)
                    }
                }
            }
            .listRowBackground(Color(.systemGray6))
            Section {
                DatePicker(selection: $date, label: { EmptyView() })
                    .datePickerStyle(GraphicalDatePickerStyle())
            }
        }
        .onAppear() {
            if selectedPets.count == 0,
               pets.count > 0,
               let item = pets.first {
                pet = item
                selectedPets = Set([item.name])
            }
            if selectedActivities.count == 0 {
                title = getActivityTypeString(activity)
                selectedActivities = Set([getActivityTypeString(activity)])
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if notification.managedObjectContext != nil {
                        notificationsViewModel.updateNotification(notification: notification,
                                                                  date: date,
                                                                  activity: activity,
                                                                  title: title,
                                                                  pet: pet,
                                                                  text: text,
                                                                  repeatPeriod: repeatPeriod,
                                                                  viewContext: viewContext)
                    }
                    else {
                        notificationsViewModel.addNotification(date: date,
                                                               activity: activity,
                                                               title: title,
                                                               pet: pet,
                                                               text: text,
                                                               repeatPeriod: repeatPeriod,
                                                               viewContext: viewContext)
                    }
                    close()
                } label: {
                    Text(notification.managedObjectContext != nil ? "Save" : "Add")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    close()
                }
                label: {
                    Text(notification.managedObjectContext != nil ? "" : "Cancel")
                }
            }
        }
    }
    
    func close() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct CheckMark: Identifiable {
    var name: String
    var id: String = UUID().uuidString
    var activity: ActivityType
    private var isChecked: Bool = false
    
    init(activity: ActivityType) {
        self.activity = activity
        self.name = getActivityTypeString(activity)
    }
}

struct CheckBoxRow : View {
    
    @Binding var selectedItems: Set<String>
    
    var name: String
    private var isSelected: Bool {
        selectedItems.contains(name)
    }
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(Color.blue)
            }
        }
        .contentShape(Rectangle())
    }
}

struct EditNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        EditNotificationView(notification: NotificationItem())
    }
}

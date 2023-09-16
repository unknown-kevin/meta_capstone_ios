//
//  Menu.swift
//  iOS Meta Capstone Project
//
//  Created by Cristina on 2023-09-15.
//

import SwiftUI
import Foundation
import CoreData

struct Menu: View {
    // MARK: PROPERTIES
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var searchText = ""
    
    // MARK: BODY
    var body: some View {
        VStack{
            Image("Logo").frame(height: 100)
            VStack {
                HStack {
                    VStack {
                        Text("Little Lemon")
                            .foregroundColor(Color("yellow"))
                            .font(.custom("Karla-Regular", size: 40))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Chicago")
                            .foregroundColor(Color("grey"))
                            .font(.custom("Karla-Regular", size: 30))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 0.5)
                        
                        Text("""
                         We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.
                         """)
                        .foregroundColor(Color("grey"))
                        .font(.custom("MarkaziText-Regular", size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineSpacing(0.15)
                    }
                    .padding(10)
                    
                    Image("Hero image")
                        .resizable()
                        .aspectRatio( contentMode: .fill)
                        .frame(maxWidth: 120, maxHeight: 140)
                        .clipShape(Rectangle())
                        .cornerRadius(16)
                        .padding(10)
                }
                .background(Color("green"))
            
                TextField("Search menu",text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.custom("Karla-Regular", size: 16))
                    .foregroundColor(Color.black)
                    .padding(10)
                    .background(Color("green"))
            }.background(Color("green"))
            
            VStack{
                Text("ORDER FOR DELIVERY!")
                    .foregroundColor(Color.black)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading,10)
                HStack{
                    Text("Starters")
                        .fontWeight(.bold)
                        .padding([.bottom, .top],8)
                        .padding([.leading, .trailing],8)
                        .background(Color("grey"))
                        .cornerRadius(16)
                        .padding(5)
                    
                    Text("Mains")
                        .fontWeight(.bold)
                        .padding([.bottom, .top],8)
                        .padding([.leading, .trailing],8)
                        .background(Color("grey"))
                        .cornerRadius(16)
                        .padding(5)

                    Text("Desserts")
                        .fontWeight(.bold)
                        .padding([.bottom, .top],8)
                        .padding([.leading, .trailing],8)
                        .background(Color("grey"))
                        .cornerRadius(16)
                        .padding(5)

                    Text("Drinks")
                        .fontWeight(.bold)
                        .padding([.bottom, .top],8)
                        .padding([.leading, .trailing],8)
                        .background(Color("grey"))
                        .cornerRadius(16)
                        .padding(5)
                }
            }

            NavigationView {
                FetchedObjects(
                    predicate:buildPredicate(),
                    sortDescriptors: buildSortDescriptors()) {
                        (dishes: [Dish]) in
                        List{
                            ForEach (dishes, id:\.self) {dish in
                                NavigationLink(destination: DishDetail(dish: dish)) {

                                    VStack{
                                        Text("\(dish.title ?? "")")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .fontWeight(.bold)
                                        HStack{
                                            VStack{
                                                Text("\(dish.dishDescription ?? "")")
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .font(.custom("MarkaziText-Regular", size: 16))

                                                Text("€\(dish.price ?? "").00")
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .fontWeight(.medium)
                                                    .padding(2)
                                            }
                                        AsyncImage(url: URL(string: dish.image ?? "")){
                                            image in image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 80,height: 100)
                                                .clipped()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 80)
                                        }
                                    }
                                }
                            }
                        }
                    }
            }
            .listStyle(.plain)
            
        }.onAppear(perform: getMenuData)
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText, "hi")
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    
    func getMenuData() {
            let persistence = PersistenceController.shared
            let serverUrl = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
            let url = URL(string: serverUrl)!
            let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    if let menuList = try? decoder.decode(MenuList.self, from: data) {
                        
                        let fullMenu = menuList.menu

                        for menuItem in fullMenu {
                            let newDish = Dish(context: viewContext)
                            newDish.title = menuItem.title
                            newDish.image = menuItem.image
                            newDish.price = menuItem.price
                            newDish.dishDescription = menuItem.description
                        }
                        try? viewContext.save()
                    }
                }
            }
            task.resume()
        }
    
}

// MARK: PREVIEWS
struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}

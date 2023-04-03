//
//  ApiViewModel.swift
//  ApiCalledSUI
//
//  Created by Guru Mahan on 30/12/22.
//

import Foundation
class ApiViewModel: ObservableObject {
    
    @Published var isSelected:innerData?
    @Published var dataList : ApiModel?
    var jsonvalue = [innerData]()
    var link = "https://datausa.io/api/data?drilldowns=Nation&measures=Population"
    
    func loadData() async {
        guard let url = URL(string: link) else{print("Invalid URL")
            return
        }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(ApiModel.self, from: data){
                DispatchQueue.main.async {
                    self.jsonvalue = decodedResponse.data
                    self.dataList = decodedResponse
                    print(self.jsonvalue)
                }
            }
        }catch{
            print("Invalid data")
        }
    }
}

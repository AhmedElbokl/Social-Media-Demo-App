//
//  UIImage+ConvertStringUrlToUIImage.swift
//  Social Media Demo App
//
//  Created by ReMoSTos on 23/10/2023.
//

import Foundation
import UIKit

extension UIImageView {
    // convert From String Url To UIImage
    func convertFromStringUrlToUIImage(stringUri: String){
        if let urlImage = URL(string: stringUri ) {
            URLSession.shared.dataTask(with: urlImage) { (data, response, error) in
                guard let imageData = data else { return }
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
            }.resume()
        }
    }
    
// Make Circular Image
    func makeCircularImage(){
        self.layer.cornerRadius = self.frame.width / 2
    }
}

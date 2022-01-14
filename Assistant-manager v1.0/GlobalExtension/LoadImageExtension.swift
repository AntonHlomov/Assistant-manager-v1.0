//
//  LoadImageExtension.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 14/01/2022.
//
//функция которая достает фото аватарки из базы кеширует ее, что бы при переключении в таб баре она не подгружалась заново

import Foundation
import UIKit

var imageCache = [String: UIImage]()//переменная кеша

extension UIImageView {
func loadImage(with urlString: String)  {
    // проверка есть ли в кеше фото
    if let cachedImage = imageCache[urlString] {
        self.image = cachedImage
        return
    }
    //определяем ссылку фото в базе
    guard let url = URL(string: urlString) else {return}
    //вытаскиваем фото из базы
    URLSession.shared.dataTask(with: url) { (data, response, err) in
        if let err = err {
            print("Failed to load image: ",err.localizedDescription)
            return
        }
        guard let imageData = data else {return}
        let profileImage =  UIImage(data: imageData)
        imageCache[url.absoluteString] = profileImage
        DispatchQueue.main.async {
            self.image = profileImage
        }
    }.resume() // если запрос подвис запрос повториться
  }
}

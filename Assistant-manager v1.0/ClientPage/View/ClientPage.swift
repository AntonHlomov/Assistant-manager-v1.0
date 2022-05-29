//
//  ClientPage.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 29/05/2022.
//

import UIKit

class ClientPage: UIViewController {
    var presenter: ClientPagePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//связывание вью с презентером что бы получать от него ответ и делать какие то действия в вью
extension ClientPage: ClientPageProtocol {
   
    

}

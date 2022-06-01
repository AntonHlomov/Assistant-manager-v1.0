//
//  OptionesController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 12/05/2022.
//

import UIKit

class OptionesController: UIViewController {
    var presenter: OptionesViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.appColor(.whiteAndPinkDetailsAssistant) // меняем цвет кнопки выйти
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func backTapped() {
        presenter.goToBackTappedViewFromRight()
    }
}
//связывание вью с презентером что бы получать от него ответ и делать какие то действия в вью
extension OptionesController: OptionesViewProtocol {

}

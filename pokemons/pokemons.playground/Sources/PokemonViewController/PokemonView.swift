import Foundation
import RxSwift
import RxCocoa

import Foundation

public struct DisplayOutput {
    
    var label: String?
    var data: String
}

public class PokemonView {
    
    // MARK: -
    // MARK: Initialization
    
    weak var controller: PokemonController?
    let disposeBag = DisposeBag()
    
    // MARK: -
    // MARK: Inititalization
    
    public init(controller: PokemonController) {
        self.controller = controller
        
        self.prepareObserving()
    }
    
    // MARK: -
    // MARK: Public
    
    public func display(output: [DisplayOutput]) {
        output.forEach { output in
            var text = ""
            
            if let label = output.label {
                text += "\(label): "
            }
            text += output.data
            
            print(text)
        }
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareObserving() {
        self.controller?.statesHandler.bind { controller in
            
            switch controller {
            case .display(output: let output):
                self.display(output: output)
            }
        }.disposed(by: disposeBag)
    }
}


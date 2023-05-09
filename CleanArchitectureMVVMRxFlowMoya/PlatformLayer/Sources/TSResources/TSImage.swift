//
//  TSImage.swift
//  
//
//  Created by TAE SU LEE on 2023/05/05.
//

import UIKit
import SwiftUI

public func TSImage(named name: String) -> UIImage? {
    UIImage(named: name, in: Bundle.module, compatibleWith: nil)
}

public func TSImage(_ name: String) -> Image? {
    Image(name, bundle: Bundle.module)
}

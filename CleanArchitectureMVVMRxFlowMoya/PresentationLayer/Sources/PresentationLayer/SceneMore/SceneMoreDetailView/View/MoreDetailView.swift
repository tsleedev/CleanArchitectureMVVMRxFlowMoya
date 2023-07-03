//  
//  MoreDetailView.swift
//  
//
//  Created by TAE SU LEE on 2023/03/22.
//

import DILayer // For Preview
import TSCoreUI
import SwiftUI

struct MoreDetailView: View {
    var body: some View {
        Text("DetailView")
    }
}

#if canImport(SwiftUI) && DEBUG
import DILayer

struct MoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        return MoreDetailView()
    }
}
#endif

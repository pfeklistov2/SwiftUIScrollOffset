/**
*  SwiftUIScrollOffset
*  Copyright (c) Ciaran O'Brien 2024
*  MIT license, see LICENSE file for details
*/

import Combine
import SwiftUI

internal final class ScrollOffsetState: ObservableObject {
    @Published private(set) var value = CGFloat.zero
    
    func update(edge: Edge, id: AnyHashable?, range: ClosedRange<CGFloat>) {
        self.edge = edge
        self.range = range
        
        guard self.id != id else { return }
        
        self.id = id
        updateValue()
        
        let publisher = ScrollOffsetStore.shared
            .offsetChangedSubject
            .filter { $0 == id }
            .map { _ in () }
            .eraseToAnyPublisher()
        
        subscriber = publisher.sink { [weak self] _ in
            self?.updateValue()
        }
    }
    
    private var edge: Edge? = nil
    private var id: AnyHashable? = nil
    private var range: ClosedRange<CGFloat> = -CGFloat.infinity...CGFloat.infinity
    private var subscriber: AnyCancellable?
    
    private func updateValue() {
        let edgeOffset: CGFloat = if let id, let edge, let offset = ScrollOffsetStore.shared[offset: id] {
            offset[edge]
        } else {
            .zero
        }
        
        let newValue = min(max(edgeOffset, range.lowerBound), range.upperBound)
        
        if value != newValue {
            value = newValue
        }
    }
}

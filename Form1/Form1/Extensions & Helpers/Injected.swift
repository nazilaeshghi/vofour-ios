//
//  Injected.swift
//  forMe From
//
//  Created by Hosseini Zadeh, Morteza on 2023-06-12.
//  Copyright © 2023 Vofour. All rights reserved.
//

import Foundation

@propertyWrapper
struct Injected<T> {
    private let keyPath: WritableKeyPath<InjectedValues, T>
    var wrappedValue: T {
        get { InjectedValues[keyPath] }
        set { InjectedValues[keyPath] = newValue }
    }
    
    init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}

/// Provides access to injected dependencies.
struct InjectedValues {
    
    /// This is only used as an accessor to the computed properties within extensions of `InjectedValues`.
    private static var current = InjectedValues()
    
    /// A static subscript for updating the `currentValue` of `InjectionKey` instances.
    static subscript<K>(key: K.Type) -> K.Value where K : InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }
    
    /// A static subscript accessor for updating and references dependencies directly.
    static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

public protocol InjectionKey {

    /// The associated type representing the type of the dependency injection key's value.
    associatedtype Value

    /// The default value for the dependency injection key.
    static var currentValue: Self.Value { get set }
}


private struct DataManagerKey: InjectionKey {
    static var currentValue: DataManager = DataManager(dataProvider: ReqalmDataProvider())
}

private struct NotificationManagerKey: InjectionKey {
    static var currentValue: NotificationManagable = LocalNotificationManager()
}

extension InjectedValues {
    var localNotificationProvider: NotificationManagable {
        get { Self [NotificationManagerKey.self] }
        set { Self [NotificationManagerKey.self] = newValue }
    }
}

extension InjectedValues {
    var dataManagerProvider: DataManager {
        get { Self [DataManagerKey.self] }
        set { Self [DataManagerKey.self] = newValue }
    }
}

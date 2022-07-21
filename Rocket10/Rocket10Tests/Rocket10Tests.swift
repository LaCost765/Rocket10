//
//  StringCompressorTests.swift
//  Rocket10Tests
//
//  Created by Egor Baranov on 21.07.2022.
//

import XCTest

class StringCompressorTests: XCTestCase {

    let compressor = StringCompressor()
    
    /// Тест на корректность сжатия строки
    func testCompressFunctionResults() throws {
        
        // Arrange
        let testData: [String : String] = [
            "": "",
            "aaaa bbbb": "a4 1b4",
            "aa   aaaaa bb c": "a2 3a5 1b2 1c1",
            "aa777aaanr77bb": "a273a3n1r172b2",
            "a": "a",
            "abcd": "abcd",
            "aa": "a2",
            "aaaa": "a4",
        ]
        
        // Act + Assert
        for (key, value) in testData {
            let compressed = compressor.compress(key)
            XCTAssertEqual(
                value,
                compressed.0,
                "❌ Ошибка: \(compressed.0) не равно \(value)"
            )
        }
        
        print("✅ StringCompressorTests.testCompressFunctionResults")
    }
    
    /// Проверяем объем памяти, который использует алгоритм сжатия строки
    func testCompressFunctionMemoryUsage() throws {
        
        // данная строка займет 5 мб в памяти
        var string = String.init(repeating: "a", count: 1024 * 1024 * 5)
        
        // фиксируем текущее потребление памяти
        var currentMemoryUsage = memoryFootprint()
        
        // получаем объем памяти при выполнении сжатия
        var memoryUsage = compressor.compress(string).1
        
        // получаем разницу, которая по идее должна быть равна 0
        var memoryUsageDifference = memoryUsage - currentMemoryUsage
        
        // проверяем, что меньше 1, учитывая накладные и случайные расходы
        XCTAssertTrue(
            memoryUsageDifference < 1,
            "❌ Ошибка: алгоритм использует \(memoryUsageDifference) MB"
        )
        
        // повторяем проверку с более длинной строкой
        // данная строка займет 50 мб в памяти
        string = String.init(repeating: "a", count: 1024 * 1024 * 50)
        currentMemoryUsage = memoryFootprint()
        memoryUsage = compressor.compress(string).1
        memoryUsageDifference = memoryUsage - currentMemoryUsage
        XCTAssertTrue(
            memoryUsageDifference < 1,
            "❌ Ошибка: алгоритм использует \(memoryUsageDifference) MB"
        )
        
        print("✅ StringCompressorTests.testCompressFunctionMemoryUsage")
    }
}

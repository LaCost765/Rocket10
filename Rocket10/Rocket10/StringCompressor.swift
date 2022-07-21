//
//  StringCompressor.swift
//  Rocket10
//
//  Created by Egor Baranov on 21.07.2022.
//

import Foundation

class StringCompressor {

    /// Сжать строку по повторяющимся символам
    /// Возвращает сжатую строку и объем памяти, занятый при выполнении
    /// Если сжатая строка длиннее исходной, вернется исходная строка
    func compress(_ string: String) -> (String, Float) {

        var result = ""
        
        // пара, хранящая текущий символ и кол-во его вхождений подряд
        var currentPair: (character: Character, count: Int)?
        
        for char in string {
            // если пара не инициализирована - создаем с текушим символом
            if currentPair == nil {
                currentPair = (character: char, count: 1)
            // если текущий символ совпадает с сохраненным в паре, то увеличиваем кол-во вхождений на 1
            } else if currentPair?.character == char {
                currentPair?.count += 1
            // иначе получаем другой символ, переводим значение текущей пары в результирующую строку
            // и обновляем пару с новым символом
            } else if let pair = currentPair {
                result += "\(pair.character)\(pair.count)"
                currentPair = (character: char, count: 1)
            }
        }
        
        // раскрываем опционал и добавляем в результирующую строку последнюю собранную пару
        if let currentPair = currentPair {
            result += "\(currentPair.character)\(currentPair.count)"
        }
        
        result = result.count > string.count ? string : result
        let currentMemoryUsage = memoryFootprint()
        return (result, currentMemoryUsage)
    }
}
